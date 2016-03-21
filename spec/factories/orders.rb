FactoryGirl.define do
  factory :order do
    address "1 Rainbow Rd"
    city "San Diego"
    state "CA"
    sequence(:listing_id) { |n| 1 + n }
    sequence(:buyer_id) { |n| 2 + n }
    sequence(:seller_id) { |n| 3 + n }
  end
end
