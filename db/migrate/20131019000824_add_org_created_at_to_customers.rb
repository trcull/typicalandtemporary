class AddOrgCreatedAtToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :org_created_at, :datetime
  end
end
