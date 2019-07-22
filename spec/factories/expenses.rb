FactoryBot.define do
  factory :expense do
    association :user
    amount { Faker::Commerce.price }
    assignment { Faker::Movies::Lebowski.quote }
  end
end
