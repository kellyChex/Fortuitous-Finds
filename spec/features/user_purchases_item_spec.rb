require 'rails_helper'

RSpec.feature 'user purchases item' do
  let!(:signed_in_user) { create(:user) }
  let!(:user)           { create(:user) }
  let!(:listing)        { create(:listing, user: user) }
  let!(:listing2)       { create(:listing, user: user) }

  background do
    login_as(signed_in_user, scope: :user)
  end

  context "from another users' listing" do
    it 'is successful' do
      visit listing_path(listing)
      click_on('Buy It Now')
      fill_in 'Address', with: '1 Rainbow Rd'
      fill_in 'City', with: 'San Diego'
      fill_in 'State', with: 'CA'
      click_on 'Complete Order'
      expect(page).to have_content I18n.t('messages.created', name: 'Order')
    end
  end

  context "from their own listing" do
    it 'is successful' do
      visit listing_path(listing2)
      click_on('Buy It Now')
      fill_in 'Address', with: '1 Rainbow Rd'
      fill_in 'City', with: 'San Diego'
      fill_in 'State', with: 'CA'
      click_on 'Complete Order'
      expect(page).to have_content I18n.t('messages.created', name: 'Order')
    end
  end
end
