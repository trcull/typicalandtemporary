
FactoryGirl.define do
  factory :organization do
    name FactoryGirl.generate :name
    admin_user_id 1
  end
end