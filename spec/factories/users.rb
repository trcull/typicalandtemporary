# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {Forgery::Email.address }
    password "supersecretpasswordstuff"
    after(:create) do |user, evaluator|
      l = UserOrganization.new
      l.organization = FactoryGirl.create(:organization)
      l.user = user
      l.save!
    end
    
  end
end
