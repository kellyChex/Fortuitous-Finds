require 'rails_helper'

RSpec.describe Listing, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:orders) }

  it 'has a valid factory' do
    expect(build(:listing)).to be_valid
  end

  it 'is invalid without a name' do
    listing = build(:listing, name: nil)
    expect(listing).to have_exactly(1).errors_on(:name)
    expect(listing).to belong_to(:user)
  end

  it 'is invalid without a description' do
    listing = build(:listing, description: nil)
    expect(listing).to have_exactly(1).errors_on(:description)
  end

  it 'is invalid without a price' do
    listing = build(:listing, price: nil)
    expect(listing).to have_exactly(2).errors_on(:price)
  end

  it 'is invalid when price is not an integer' do
    listing = build(:listing, price: 'abc')
    expect(listing).to have_exactly(1).errors_on(:price)
  end
end
