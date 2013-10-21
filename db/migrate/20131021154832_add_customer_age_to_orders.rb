class AddCustomerAgeToOrders < ActiveRecord::Migration
  def change
    Order.transaction do |t|
      add_column(:orders, :customer_age, :integer)
      add_column(:orders, :next_previous_order_id, :integer)
      add_column(:orders, :num_previous_purchases, :integer)
    end
  end
end
