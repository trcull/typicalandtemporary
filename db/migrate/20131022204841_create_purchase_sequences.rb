class CreatePurchaseSequences < ActiveRecord::Migration
  def change
    User.transaction do 
      create_table :purchase_sequences do |t|
        t.float :net_score
        t.float :product1_score
        t.float :product2_score
        t.integer :product_sequence_count
        t.integer :product1_id
        t.float :product1_avg_customer_age
        t.float :product1_avg_num_prev_purchases
        t.integer :product2_id
        t.float :product2_avg_customer_age
        t.float :product2_avg_num_prev_purchases
      end
      
      begin
        #execute "drop view follow_on_purchases;"
      rescue
        #do nothing
      end
      
      execute "create view follow_on_purchases as
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
          group by oi.product_id, oi_s.product_id;"
    end
  end
end
