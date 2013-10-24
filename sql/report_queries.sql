

update customers c
set org_created_at = (select min(org_created_at) from orders o where o.customer_id = c.id)
where c.org_created_at is null
;

update orders o
set customer_age = o.org_created_at::date - c.org_created_at::date,
 total = (select sum((ol.price * ol.quantity)+(case when ol.additional_charges is null then 0 else ol.additional_charges end)) as thevalue from order_lines ol where ol.order_id = o.id group by ol.order_id)			
 from customers c
where o.customer_age is null
and o.customer_id = c.id;

delete from orders where total < 0;

update orders o
set 
next_previous_order_id = (select max(o_s.id) as order_id
 				from orders o_s 
 				where o_s.org_created_at < o.org_created_at 
 					and o_s.org_created_at = (select max(o_s2.org_created_at) 
 											from orders o_s2 
 											where 
 												o_s2.org_created_at < o.org_created_at
 												and o_s2.organization_id = o.organization_id
 												and o_s2.customer_id = o.customer_id)
 					and o_s.organization_id = o.organization_id
 					and o_s.customer_id = o.customer_id
 				),
 num_previous_purchases = (select count(1) from orders o_s where o_s.org_created_at < o.org_created_at and o_s.customer_id = o.customer_id)
 from customers c
where 
 o.next_previous_order_id is null
 and o.customer_id = c.id;

insert into customer_cohort_schemes (name) values ('year-month');

--populate customer cohorts
truncate table customer_cohorts;
insert into 
	customer_cohorts (customer_cohort_scheme_id, customer_id, cohort_value_int, cohort_value)
select
	1,
	c.id,
	2000 + date_part('year', c.org_created_at)::int + (date_part('month', c.org_created_at)::int * 10000),
	'20' || date_part('year', c.org_created_at) || '-' || trim(to_char(date_part('month',c.org_created_at)::int,'00'))
from
	customers c
where
	c.organization_id = 2;

insert into 
	customer_cohorts (customer_cohort_scheme_id, customer_id, cohort_value_int, cohort_value)
select
	1,
	c.id,
	date_part('year', c.org_created_at)::int + (date_part('month', c.org_created_at)::int * 10000),
	date_part('year', c.org_created_at) || '-' || trim(to_char(date_part('month',c.org_created_at)::int,'00'))
from
	customers c
where
	c.organization_id != 2;
	
--purchase counts by customer
drop view orders_by_customer;
create view orders_by_customer as
select c.id, 
		c.organization_id,
		avg(case when o.next_previous_order_id is null then 0 else o.org_created_at::date - prev_o.org_created_at::date end) as avg_days_between_orders,
		max(case when o.next_previous_order_id is null then 0 else o.org_created_at::date - prev_o.org_created_at::date end) as max_days_between_orders,
		count(1) as num_orders,
		sum(o.total) as total_order_value,
		max(case when o.next_previous_order_id is null or o.total < 0 then 0 else 1 end) as repeat_purchases_flag
	from
		orders o
	inner join customers c on c.id = o.customer_id
	left outer join orders prev_o on prev_o.id = o.next_previous_order_id
	group by 
		c.id, c.organization_id
	;

--distribution of purchase counts by customer age
select count(1) as num_purchases,
	age.customer_age
from
	orders o
inner join (select generate_series as customer_age from generate_series(0,600)) as age on age.customer_age = o.customer_age
where o.organization_id = 2
group by age.customer_age
order by age.customer_age asc;

--purchase count histogram
select 
	orders_by_customer.num_orders,
	count(1) as num_customers
from
	orders_by_customer
where
	organization_id = 2
group by 
	orders_by_customer.num_orders
order by
	orders_by_customer.num_orders;
	
--first repeat purchases
select
	count(1) as num_orders,
	o.customer_age
from
	orders o 
inner join customers c on c.id = o.customer_id
where 
	o.organization_id = 2
	and o.num_previous_purchases = 1
group by
	o.customer_age
order by 
	o.customer_age asc;

--average number of orders per month
select avg(num_orders) avg_num_orders, 
	avg(avg_order_size) as avg_order_size, 
	avg(num_repeat_purchases) as avg_num_repeat_purchases,
	(0.01*avg(num_orders)*avg(avg_order_size)) as revenue_per_1pct_improvement
from
(
select count(1) as num_orders,
avg(o.total) as avg_order_size,
sum(case when o.num_previous_purchases > 0 then 1 else 0 end) as num_repeat_purchases,
( date_part('year', o.org_created_at) || '-' || trim(to_char(date_part('month',o.org_created_at)::int,'00')))
from orders o
group by ( date_part('year', o.org_created_at) || '-' || trim(to_char(date_part('month',o.org_created_at)::int,'00')))
) orders_with_dates

select o.num_previous_purchases, count(1) from orders o 
where  organization_id = 2
group by o.num_previous_purchases;

--age at first/second/third purchase
select
   o.num_previous_purchases,
   o.customer_age,
   count(1) as num_orders
from
   orders o 
inner join customers c on c.id = o.customer_id
where 
   o.organization_id = 2
group by
   o.num_previous_purchases, o.customer_age
order by 
   o.num_previous_purchases, o.customer_age asc;

--purchase counts by cohort	
select
	cohort.cohort_value,
	--orders_by_customer.repeat_purchases_flag,
	sum(num_orders) as total_orders,
	avg(num_orders) as avg_num_orders,
	avg(avg_days_between_orders) as cohort_avg_days_between_orders,
	avg(max_days_between_orders) as cohort_avg_max_days_between_orders,
	avg(total_order_value) as cohort_avg_total_order_value,
	sum(total_order_value) as cohort_total_order_value
from
	orders_by_customer
inner join customer_cohorts cohort on cohort.customer_id = orders_by_customer.id and cohort.customer_cohort_scheme_id = 1
where 
	orders_by_customer.organization_id = 2
group by
	--orders_by_customer.repeat_purchases_flag, 
	cohort.cohort_value
order by
	cohort.cohort_value;


--purchase sequences
drop view follow_on_purchases;
create view follow_on_purchases as
select count(1) as num_purchases, 
	oi.product_id as product1_id, 
	avg(o.customer_age) as product1_avg_customer_age, 
	avg(o.num_previous_purchases) as product1_avg_num_previous_purchases,
	oi_s.product_id as product2_id,
	avg(o_s.customer_age) as product2_avg_customer_age,
	avg(o_s.num_previous_purchases) as product2_avg_num_previous_purchases
from orders o 
inner join order_lines oi on oi.order_id = o.id
inner join orders o_s ON o_s.org_created_at > o.org_created_at and o_s.customer_id = o.customer_id
inner join order_lines oi_s ON oi_s.order_id = o_s.id
group by oi.product_id, oi_s.product_id;


   
truncate table purchase_sequences;
insert into purchase_sequences 
(net_score,product1_score,product2_score,product_sequence_count,product1_id,product2_id,
	product1_avg_customer_age, product1_avg_num_prev_purchases,
	product2_avg_customer_age, product2_avg_num_prev_purchases)
select ((follow_on_purchases.num_purchases::float/product_commonness1.num_purchases) 
		+ (prd2_rpt_purchases.num_purchases::float/product_commonness2.num_purchases)) as commonness,
	(follow_on_purchases.num_purchases::float/product_commonness1.num_purchases) as commoness1,
	(prd2_rpt_purchases.num_purchases::float/product_commonness2.num_purchases) as commoness2,
	follow_on_purchases.num_purchases, follow_on_purchases.product1_id, follow_on_purchases.product2_id,
	product1_avg_customer_age, product1_avg_num_previous_purchases,
	product2_avg_customer_age, product2_avg_num_previous_purchases
from follow_on_purchases
inner join (select count(1) as num_purchases, oi.product_id
	from order_lines oi
	group by oi.product_id) product_commonness1 on product_commonness1.product_id = follow_on_purchases.product1_id
inner join (select count(1) as num_purchases, oi.product_id
	from order_lines oi
	group by oi.product_id) product_commonness2 on product_commonness2.product_id = follow_on_purchases.product2_id
inner join (select product2_id, count(1) as num_purchases 
	from follow_on_purchases 
	group by product2_id) as prd2_rpt_purchases on prd2_rpt_purchases.product2_id = follow_on_purchases.product2_id;	


select seq.product2_avg_customer_age, p1.org_id as p1_name,p2.org_id as p2_name,  
	seq.net_score,
	seq.product_sequence_count,
	seq.product2_avg_customer_age
from 
	purchase_sequences seq
inner join products p1 on p1.id = seq.product1_id
inner join products p2 on p2.id = seq.product2_id
order by seq.product_sequence_count desc, seq.product2_avg_customer_age asc, seq.net_score desc;

--domain penetration
select 	c.id as cust_id, 
	concat('resources/slide_imgs/', suggestions.product_id ,'/', p2_img.id, '/', p2_img.filename, '-l.jpg') as p2_img,
	p2_url.url as p2_url,
	suggestions.affinity_score,
	suggestions.domain_penetration
from (select distinct oi_s.cust_id from aged_order_items oi_s where oi_s.order_date <= date_sub(date(now()),interval 15 day)
 and oi_s.order_date > date_sub(date(now()),interval 16 day) 
 and not exists (select 1 from orders o_s where o_s.time > oi_s.order_date and o_s.cust_id = oi_s.cust_id) 
) oi
inner join enhanced_customers c on c.id = oi.cust_id
inner join (select c_ss.email_domain as cust_domain, count(distinct c_ss.id) as num_customers, p_ss.name as p2_name, p_ss.id as product_id,
        	count(distinct c_ss.id)/(select count(1) from enhanced_customers c_s3 where c_s3.email_domain = c_ss.email_domain) as domain_penetration, 
        	count(1) as abs_purchased, count(1)/p_counts.num_purchases as pct_product_purchased, 
        	d_counts.pct_purchases, 
        	((count(1)/p_counts.num_purchases)-d_counts.pct_purchases) as affinity_score
				from enhanced_customers c_ss
				inner join aged_order_items oi_ss on oi_ss.cust_id = c_ss.id
				inner join products p_ss on (p_ss.id = oi_ss.product_id and p_ss.active = '1')
				inner join purchases_by_product p_counts on (p_counts.product_id = p_ss.id and p_counts.num_purchases > 2)
				inner join purchases_by_domain d_counts on d_counts.email_domain = c_ss.email_domain
				group by c_ss.email_domain, p_ss.name
				having affinity_score > 0.001 
					and pct_product_purchased < 0.9 
					and abs_purchased > 1 
					and domain_penetration < 1 
					and domain_penetration > 0.01) suggestions on suggestions.cust_domain = c.email_domain
inner join product_slide_imgs p2_img on p2_img.product_id = suggestions.product_id and p2_img.priority=1
inner join (select max(id) as id, product_id, max(url) as url from product_urls where locale='en_US' group by product_id)  p2_url on p2_url.product_id = suggestions.product_id 
order by c.id, suggestions.affinity_score desc, suggestions.domain_penetration asc;
