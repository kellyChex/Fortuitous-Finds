require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:listing) }
  it { is_expected.to belong_to(:buyer) }
  it { is_expected.to belong_to(:seller) }

  it 'has a valid factory' do
    expect(build(:order)).to be_valid
  end

  it 'is invalid without an address' do
    order = build(:order, address: nil)
    expect(order).to have_exactly(1).errors_on(:address)
  end

  it 'is invalid without a city' do
    order = build(:order, city: nil)
    expect(order).to have_exactly(1).errors_on(:city)
  end

  it 'is invalid without a state' do
    order = build(:order, state: nil)
    expect(order).to have_exactly(1).errors_on(:state)
  end
end
