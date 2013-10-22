
class Batch::DataCleaner 
  def perform
    "update customers c
set org_created_at = (select min(org_created_at) from orders o where o.customer_id = c.id)
where c.org_created_at is null
;"

  "update orders o
set customer_age = o.org_created_at::date - c.org_created_at::date,
 total = (select sum((ol.price * ol.quantity)+(case when ol.additional_charges is null then 0 else ol.additional_charges end)) as thevalue from order_lines ol where ol.order_id = o.id group by ol.order_id)     
 from customers c
where o.customer_age is null
and o.customer_id = c.id;"

"delete from orders where total < 0;"

"update orders o
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
 o.next_previous_order_id is null
 o.customer_id = c.id;"

"truncate table customer_cohorts;
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
  c.organization_id != 2;"


  end
end