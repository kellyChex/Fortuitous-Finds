require 'rails_helper'

describe "Passwords" do
  it 'emails user when requesting password reset' do
    user = create(:user)
    visit new_user_session_path
    click_link 'Forgot your password?'
    fill_in 'Email', with: user.email
    click_button 'Send me reset password instructions'

    expect(page).to have_content("You will receive an email with instructions on how to reset your password in a few minutes.")
  end
end
