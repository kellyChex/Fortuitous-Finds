require 'rails_helper'

RSpec.feature 'user creates new listing' do
  before do
    @user = create(:user)
    sign_in @user
  end

  context 'with valid credentials' do
    it 'creates a profile' do
      fill_in 'Name', with: 'Kelly Chess'
      fill_in 'Email', with: 'kelly_chess@example.com'
      fill_in 'Password', with: 'Password123'
      fill_in 'Password confirmation', with: 'Password123'
      click_button 'Register'
      expect(page).to have_content I18n.t('devise.registrations.signed_up')
    end
  end

  context 'with invalid credentials' do
    it 're-renders the sign up page' do
      fill_in 'Name', with: nil
      fill_in 'Email', with: nil
      fill_in 'Password', with: nil
      fill_in 'Password confirmation', with: nil
      click_button 'Register'
      expect(current_path).to eq user_registration_path
    end
  end
end
