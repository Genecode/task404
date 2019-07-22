FactoryBot.define do
  factory :income do
    association :user
    amount { Faker::Commerce.price }
  end
end
