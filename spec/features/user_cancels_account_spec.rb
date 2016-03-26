require 'rails_helper'

RSpec.feature 'user cancels account', :js do
  let!(:user) { create(:user) }

  background do
    login_as(user, scope: :user)
    visit edit_user_registration_path
  end

  it 'is successfully destroyed' do
    click_on 'Cancel my account'
    expect(page).to have_content I18n.t('devise.registrations.destroyed')
  end
end
