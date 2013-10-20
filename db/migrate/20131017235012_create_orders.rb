class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :org_id, :null=>false
      t.datetime :org_created_at, :null=>false
      t.float :subtotal, :null=>false
      t.float :total, :null=>false
      t.integer :organization_id, :null=>false
      t.integer :customer_id, :null=>false
      t.timestamps
    end
    
    create_table :order_lines do |t|
      t.integer :order_id, :null=>false
      t.integer :quantity, :null=>false
      t.float :price, :null=>false
      t.float :tax_rate, :null=>true
      t.float :additional_charges, :null=>true
      t.integer :product_id, :null=>false
    end
  end
end
