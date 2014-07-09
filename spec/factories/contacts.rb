# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name { Faker::Name.name }
    sequence(:phone) { |n| (18889086000 + n).to_s }
    email { Faker::Internet.email(name) }
    user
  end
end
