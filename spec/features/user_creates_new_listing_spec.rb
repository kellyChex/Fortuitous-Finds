require 'rails_helper'

RSpec.feature 'User creates a new listing' do
  let!(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    visit new_listing_path
  end

  context 'with valid credentials' do
    it 'is successfully created' do
      fill_in 'Name', with: 'Lamp'
      fill_in 'Description', with: 'Found in the Cave of Wonders'
      fill_in 'Price', with: 150000.00
      attach_file 'Image', 'app/assets/images/doublerainbow.jpg'
      click_button 'Create Listing'
      expect(page).to have_content I18n.t('messages.created', name: 'Listing')
    end
  end

  context 'with invalid credentials' do
    it 'is not successfully created' do
      fill_in 'Name', with: nil
      fill_in 'Description', with: nil
      fill_in 'Price', with: nil
      attach_file 'Image', 'app/assets/images/doublerainbow.jpg'
      click_button 'Create Listing'
      expect(page).to_not have_content I18n.t('messages.created', name: 'Listing')
    end
  end
end
