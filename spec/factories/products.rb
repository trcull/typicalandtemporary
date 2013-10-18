
FactoryGirl.define do
  factory :product do
    org_id FactoryGirl.generate :org_id
    name FactoryGirl.generate :name
    org_created_at Time.now
    organization
  end
end