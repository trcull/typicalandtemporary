class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :organization_id, :null=>false
      t.string :email, :null=>true
      t.string :mobile_number, :null=>true
      t.string :org_id, :null=>false
      t.timestamps
    end
  end
end
