FactoryBot.define do
  sequence(:name) { |n| "#{n}" }

  factory :product do
    name
    description "Test description"
    price 1.0
  end
end
