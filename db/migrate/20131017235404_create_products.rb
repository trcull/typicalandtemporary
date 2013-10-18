class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :org_id, :null=>false
      t.string :name, :null=>true
      t.datetime :org_created_at, :null=>false
      t.integer :organization_id, :null=>false
      t.timestamps
    end
  end
end
