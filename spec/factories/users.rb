FactoryGirl.define do
  factory :user do    confirmed_at Time.now
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password "please123"
  end
end
