class CreateCustomerCohorts < ActiveRecord::Migration
  def change
    Customer.transaction do 
      create_table :customer_cohort_schemes do |t|
        t.string :name, :null=>false  
      end
      
      create_table :customer_cohorts do |t|
        t.integer :customer_cohort_scheme_id, :null=>false
        t.integer :customer_id, :null=>false
        t.integer :cohort_value_int, :null=>true
        t.string :cohort_value, :null=>false
      end
      
      add_index :customer_cohorts, [:customer_id, :customer_cohort_scheme_id], :unique=>true, :name=>'customer_cohort_cust_id'
  
      execute "create view orders_by_customer as
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
          c.id, c.organization_id;"
    end
  end
end
