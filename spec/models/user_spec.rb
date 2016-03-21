require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:listings) }
  it { is_expected.to have_many(:sales) }
  it { is_expected.to have_many(:purchases) }

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    expect(user).to have_exactly(1).errors_on(:name)
  end

  it 'is invalid without an email' do
    user = build(:user, email: nil)
    expect(user).to have_exactly(1).errors_on(:email)
  end

  it 'is invalid without a password' do
    user = build(:user, password: nil)
    expect(user).to have_exactly(1).errors_on(:password)
  end

  it 'is invalid with a duplicate email address' do
    create(:user, email: "hellokitty@example.com")
    user = build(:user, email: "hellokitty@example.com")
    expect(user).to_not be_valid
  end
end
