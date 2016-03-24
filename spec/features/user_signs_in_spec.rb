require 'rails_helper'

RSpec.feature 'Sign in' do
  before do
    @user = create(:user, email: 'k@xyz.com', password: 'Password123')
    visit new_user_session_path
  end

  context 'with valid credentials' do
    it 'logs user in' do
      fill_in 'Email', with: 'k@xyz.com'
      fill_in 'Password', with: 'Password123'
      click_button 'Log in'
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end
  end

  context 'with invalid credentials' do
    it 're-renders the sign in page' do
      fill_in 'Email', with: nil
      fill_in 'Password', with: nil
      click_button 'Log in'
      expect(current_path).to eq new_user_session_path
    end
  end
end
