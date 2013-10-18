# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {Forgery::Email.address }
    password "supersecretpasswordstuff"
  end
end
