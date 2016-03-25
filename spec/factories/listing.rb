FactoryGirl.define do
  factory :listing do
    name "Lamp"
    description "Found in the Cave of Wonders"
    price 100000000.00
    # image_file_name 'app/assets/images/doublerainbow.jpg'
    created_at '12/11/2014'
  end

  factory :invalid_listing, class: 'Listing' do
    name nil
  end
end
