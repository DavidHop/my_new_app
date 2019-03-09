FactoryBot.define do

sequence(:email) { |n| "user-#{n}@example.com" }

  factory :user do
    email
    password "password"
    first_name "David"
    last_name "Hopkins"
    admin false
  end

  factory :admin, class: User do
    email
    password "password"
    admin true
    first_name "Jon"
    last_name "Snow"
  end

end
