
FactoryGirl.define do
  factory :customer do
    organization
    email FactoryGirl.generate :email
    org_id FactoryGirl.generate :org_id
  end
end