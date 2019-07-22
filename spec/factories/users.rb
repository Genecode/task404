FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    age { Faker::Number.between(1, 100)}
    address { Faker::Address.full_address }
  end
end
