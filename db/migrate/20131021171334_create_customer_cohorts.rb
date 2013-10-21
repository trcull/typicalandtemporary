class CreateCustomerCohorts < ActiveRecord::Migration
  def change
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
  end
end
