FactoryGirl.define do
  factory :order do
    address "1 Rainbow Rd"
    city "San Diego"
    state "CA"
    buyer  { create(:user) }
    seller { create(:user) }
    association :listing
    created_at { Time.now }
  end
end
