
FactoryGirl.define do
  factory :order do
    org_id FactoryGirl.generate :org_id
    org_created_at DateTime.now
    subtotal 11.33
    total 12.45
    organization
    product
    customer
  end
end