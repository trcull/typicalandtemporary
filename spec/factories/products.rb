
FactoryGirl.define do
  factory :product do
    org_id FactoryGirl.generate :org_id
    name FactoryGirl.generate :name
    org_created_at DateTime.now
    organization
  end
end