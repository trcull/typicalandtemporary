
class Batch::DataCleaner 
  def perform(organization_id)
    Rails.logger.info "doing data cleaning for organization id #{organization_id}"
    @organization = Organization.find organization_id
    
    Rails.logger.info "Updating customer created at where it's null"
    User.connection.execute("update customers c
                set org_created_at = (select min(org_created_at) 
                                    from orders o where o.customer_id = c.id)
                where c.org_created_at is null
                and c.organization_id = #{organization_id}")
  
    Rails.logger.info "Updating customer age on orders"
    User.connection.execute("update orders o
                set customer_age = o.org_created_at::date - c.org_created_at::date
                from customers c
                where o.customer_age is null
                and o.customer_id = c.id
                and o.organization_id = #{organization_id}")

    #TODO: calculate totals
    #                    total = (select sum((ol.price * ol.quantity)+(case when ol.additional_charges is null then 0 else ol.additional_charges end)) as thevalue from order_lines ol where ol.order_id = o.id group by ol.order_id)     
    Rails.logger.info "updating previous order ids on orders"
    User.connection.execute("update orders o
                set next_previous_order_id = (select max(o_s.id) as order_id
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
                  num_previous_purchases = (select count(1) 
                                            from orders o_s 
                                            where o_s.org_created_at < o.org_created_at 
                                            and o_s.customer_id = o.customer_id
                                            )
                from customers c
                where o.next_previous_order_id is null
                  and o.customer_id = c.id
                  and o.organization_id = #{organization_id}")

    year_month_cohort_id = User.connection.select_value("select id from customer_cohort_schemes where name='year-month'")
    
    #Assigning customers to cohorts
    User.connection.execute("insert into customer_cohorts (customer_cohort_scheme_id, customer_id, cohort_value_int, cohort_value)
                                  select
                                    #{year_month_cohort_id},
                                    c.id,
                                    date_part('year', c.org_created_at)::int + (date_part('month', c.org_created_at)::int * 10000),
                                    date_part('year', c.org_created_at) || '-' || trim(to_char(date_part('month',c.org_created_at)::int,'00'))
                                  from
                                    customers c
                                  left outer join customer_cohorts coh on (coh.customer_id = c.id and coh.customer_cohort_scheme_id = #{year_month_cohort_id})
                                  where
                                    c.organization_id = #{organization_id}
                                    and coh.id is null")


  end
end