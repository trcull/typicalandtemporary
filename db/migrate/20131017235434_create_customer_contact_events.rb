class CreateCustomerContactEvents < ActiveRecord::Migration
  def change
    create_table :customer_contact_events do |t|
      t.integer :customer_id, :null=>false
      t.string :type, :null=>false
      t.integer :contact_template_id, :null=>false
      t.timestamps
    end
    
    create_table :contact_templates do |t|
      t.integer :organization_id, :null=>false
    end
    
    create_table :contact_preferences do |t|
      t.integer :customer_id, :null=>false
      t.integer :contact_template_id, :null=>false
      t.boolean :is_allowed, :null=>false
      t.timestamps
    end
  end
end
