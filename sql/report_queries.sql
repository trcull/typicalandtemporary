
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
 num_previous_purchases = (select count(1) from orders o_s where o_s.org_created_at < o.org_created_at and o_s.customer_id = o.customer_id),
 from customers c
where 
 o.customer_id = c.id;

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

