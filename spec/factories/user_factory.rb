FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n+1}@example.com" }
    password 'password'

    trait :admin do
      admin true
    end
  end
end
