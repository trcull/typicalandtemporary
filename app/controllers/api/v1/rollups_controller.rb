
class Api::V1::RollupsController < Api::V1::ApiController
  before_filter :logged_in_user_belongs_to_organization!
  
  def index
    
  end
  
  
  def order_counts_by_customer_age
    rv = {}
    total_orders = total_order_count
    sql = sanitize(["select age.customer_age,
                                        count(1) as num_orders
                                    from
                                      orders o
                                    inner join (select generate_series as customer_age from generate_series(0,600)) as age on age.customer_age = o.customer_age
                                    where o.organization_id = %s
                                    group by age.customer_age
                                    order by age.customer_age asc;", current_user.current_organization.id])
    stats = Order.connection.select_rows(sql)

    rv[:total_orders] = total_orders 
    rv[:customer_ages] = stats.collect{|row| row[0]}                                
    rv[:pct_orders] = []
    rv[:pct_cumulative] = []
    rv[:num_orders] = []
    pct_so_far = 0
    stats.map {|row| 
      pct = row[1].to_f/total_orders
      rv[:pct_orders][row[0].to_i] = pct
      pct_so_far += pct
      rv[:pct_cumulative][row[0].to_i] = pct_so_far
      rv[:num_orders][row[0].to_i] = row[1].to_i
    }
    render :json => rv.to_json
  end
  
  def total_order_count()
    Order.connection.select_value(
          sanitize(["select count(1) from orders where organization_id = %s",current_user.current_organization.id])).to_i
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
          sanitize(["select count(1) from #{orders_by_customer} oc where oc.organization_id = %s", current_user.current_organization.id])).to_i
    rv[:total_customers] = total_customers
    stats = Order.connection.select_rows(sanitize(["select 
                                    oc.num_orders,
                                    count(1) as num_customers
                                  from
                                    #{orders_by_customer} oc
                                  where
                                    oc.organization_id = %s
                                  group by 
                                    oc.num_orders
                                  order by
                                    oc.num_orders;", current_user.current_organization.id])) 
    rv[:num_orders] = stats.collect{|row| row[0]}                                
    rv[:pct_customers] = []
    rv[:pct_cumulative] = []
    rv[:num_customers] = []
    pct_so_far = 0
    stats.map {|row| 
      pct = row[1].to_f/total_customers
      pct_so_far += pct
      rv[:pct_customers][row[0].to_i-1] = pct
      rv[:num_customers][row[0].to_i-1] = row[1].to_i
      rv[:pct_cumulative][row[0].to_i] = pct_so_far
    }
    render :json => rv.to_json
  end
  
  def age_at_repeat_order_histogram
    rv = {}
    total_orders = total_order_count
    rv[:total_orders] = total_orders
    order_counts_by_purchase_number = {}
    Order.connection.select_rows(sanitize(["select o.num_previous_purchases,
                                            count(1) as num_orders from orders o where o.organization_id = ?
                                            group by o.num_previous_purchases", current_user.current_organization.id])).each do |row|
    
      order_counts_by_purchase_number[row[0]] = row[1].to_i   
    end
    rv[:order_counts_by_purchase_number] = order_counts_by_purchase_number
    
    stats = Order.connection.select_rows(sanitize(["select
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
                                    o.num_previous_purchases, o.customer_age asc;",current_user.current_organization.id]))
    num_orders_series = Hash.new {|hash, key| hash[key] = []}
    cumulative_pct_series = Hash.new {|hash, key| hash[key] = []}
    cumulative_by_num_purchases = Hash.new {|hash, key| hash[key] = 0}
    pct_orders_series = Hash.new {|hash, key| hash[key] = []}
    stats.each do |row| 
      num_prev_purchases = row[0]
      num_orders_series[num_prev_purchases] << [row[1].to_i, row[2].to_i]
      pct = row[2].to_f/order_counts_by_purchase_number[num_prev_purchases]
      pct_orders_series[num_prev_purchases] << [row[1].to_i, pct]
      cumulative_by_num_purchases[num_prev_purchases] = cumulative_by_num_purchases[num_prev_purchases] + pct
      cumulative_pct_series[num_prev_purchases] << [row[1].to_i,cumulative_by_num_purchases[num_prev_purchases]]
    end
    rv[:num_customers] = num_orders_series
    rv[:pct_cumulative] = cumulative_pct_series
    rv[:pct_customers] = pct_orders_series
    render :json => rv.to_json    
  end
  
end