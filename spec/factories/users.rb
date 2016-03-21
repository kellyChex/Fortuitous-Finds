FactoryGirl.define do
  factory :user do
    name "Kelly"
    sequence(:email) { |n| "kelly#{n}@example.com" }
    sequence(:encrypted_password) { |n| "password#{n}" }
    password "password123"
  end
end
