class AddSomeIndexes < ActiveRecord::Migration
  def change
    Order.transaction do |t|
      add_index :orders, [:org_id,:organization_id], :unique=>true
      add_index :customers, [:org_id,:organization_id], :unique=>true
      add_index :products, [:org_id,:organization_id], :unique=>true
      add_index :orders, [:organization_id], :unique=>false
      add_index :customers, [:organization_id], :unique=>false
      add_index :products, [:organization_id], :unique=>false

      add_index :orders, [:customer_id], :unique=>false
      add_index :orders, [:org_created_at, :organization_id]
      add_index :customers, [:org_created_at, :organization_id]
      add_index :order_lines, [:order_id], :unique=>false
      add_index :order_lines, [:order_id, :product_id], :unique=>true
      add_index :order_lines, [:product_id, :order_id], :unique=>true
    end
  end
end
