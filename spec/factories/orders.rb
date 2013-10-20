
FactoryGirl.define do
  factory :order do
    org_id FactoryGirl.generate :org_id
    org_created_at Time.now
    subtotal 11.33
    total 12.45
    organization
    customer
  end
end