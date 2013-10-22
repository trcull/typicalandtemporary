
class Api::V1::RollupsController < Api::V1::ApiController
  before_filter :logged_in_user_belongs_to_organization!
  
  def order_counts_by_customer_age
    rv = {}
    total_orders = total_order_count
    rv[:total_orders] = total_orders
    stats = Order.connection.select_values(sanitize(["select age.customer_age,
                                        count(1) as num_orders
                                    from
                                      orders o
                                    inner join (select generate_series as customer_age from generate_series(0,600)) as age on age.customer_age = o.customer_age
                                    where o.organization_id = ?
                                    group by age.customer_age
                                    order by age.customer_age asc;", @organization_id]))
    rv[:num_orders] = stats.map {|row| [row[0],row[1]]}
    rv[:pct_orders] = stats.map {|row| [row[0],row[1].to_f/total_orders]}
    render :json => rv.to_json
  end
  
  def total_order_count()
    Order.connection.select_value(
          sanitize(["select count(1) from orders where organization_id = %s",@organization_id]))
  end
  
  def sanitize(args)
    ActiveRecord::Base.send(:sanitize_sql_array, args)  
  end
  
  #there's a view named orders_by_customer with this same structure, but ActiveRecord isn't recognizing it.  So we have to reproduce it here
  def orders_by_customer
    "(select c.id, 
      c.organization_id,
      count(1) as num_orders
    from
      orders o
    inner join customers c on c.id = o.customer_id
    group by 
      c.id, c.organization_id) "   
  end
  
  def order_count_histogram
    rv = {}
    total_customers = Order.connection.select_value(
          sanitize(["select count(1) from #{orders_by_customer} oc where oc.organization_id = %s", @organization_id]))
    rv[:total_customers] = total_customers
    stats = Order.connection.select_values(sanitize(["select 
                                    oc.num_orders,
                                    count(1) as num_customers
                                  from
                                    #{orders_by_customer} oc
                                  where
                                    oc.organization_id = %s
                                  group by 
                                    oc.num_orders
                                  order by
                                    oc.num_orders;", @organization_id])) 
    rv[:num_customers] = stats.map {|row| [row[0],row[1]]}
    rv[:pct_customers] = stats.map {|row| [row[0],row[1].to_f/total_customers]}
    render :json => rv.to_json
  end
  
  def age_at_repeat_order_histogram
    rv = {}
    total_orders = total_order_count
    rv[:total_orders] = total_orders
    order_counts_by_purchase_number = {}
    Order.connection.select_values(sanitize(["select o.num_previous_purchases,
                                            count(1) as num_orders from orders o where o.organization_id = ?
                                            group by o.num_previous_purchases", @organization_id])).each do |row|
    
      order_counts_by_purchase_number[row[0]] = row[1]    
    end
    rv[:order_counts_by_purchase_number] = order_counts_by_purchase_number
    
    stats = Order.connection.select_values(sanitize(["select
                                    o.num_previous_purchases,
                                    o.customer_age,
                                    count(1) as num_orders
                                  from
                                    orders o 
                                  inner join customers c on c.id = o.customer_id
                                  where 
                                    o.organization_id = ?
                                  group by
                                    o.num_previous_purchases, o.customer_age
                                  order by 
                                    o.num_previous_purchases, o.customer_age asc;",@organization_id]))
    num_orders_series = {}
    pct_orders_series = {}
    stats.each do |row| 
      num_orders_series[row[0]] = [row[1],row[2]]
      pct_order_series[row[0]] - [row[1], row[2].to_f/order_counts_by_purchase_number[row[0]]]
    end
    rv[:num_customers] = num_orders_series
    rv[:pct_customers] = pct_orders_series
    render :json => rv.to_json    
  end
  
end