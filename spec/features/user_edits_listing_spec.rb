require 'rails_helper'

RSpec.feature 'User edits listing' do
  let!(:user)    { create(:user) }
  let!(:listing) { create(:listing, user: user) }

  background do
    login_as(user, scope: :user)
    visit seller_path
  end

  context 'with valid credentials' do
    it 'is successfully edited' do
      within all('.dropdown-menu').last do
        click_on('Edit')
      end
      fill_in 'Name', with: 'Aladdin Lamp'
      click_button 'Update Listing'
      expect(page).to have_content I18n.t('messages.updated', name: 'Listing')
    end
  end

  context 'with invalid credentials' do
    it 'is not successfully edited' do
      within all('.dropdown-menu').last do
        click_on('Edit')
      end
      fill_in 'Name', with: nil
      click_button 'Update Listing'
      expect(page).to_not have_content I18n.t('messages.updated', name: 'Listing')
    end
  end
end
