require 'rails_helper'

RSpec.feature 'User edits account' do
  let!(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
  end

  context "with valid attributes" do
    it 'is successful updated' do
      visit edit_user_registration_path
      fill_in 'Name', with: 'Bill'
      fill_in 'Current password', with: 'password123'
      click_on 'Update'
      expect(page).to have_content I18n.t('devise.registrations.updated')
    end
  end

  context "invalid attributes" do
    it 'is not successful updated' do
      visit edit_user_registration_path
      fill_in 'Name', with: nil
      fill_in 'Current password', with: 'password123'
      click_on 'Update'
      expect(page).to_not have_content I18n.t('devise.registrations.updated')
    end
  end
end
