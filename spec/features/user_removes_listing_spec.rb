require 'rails_helper'

RSpec.feature 'user removes listing', :js do
  let!(:user)    { create(:user) }
  let!(:listing) { create(:listing, user: user) }

  background do
    login_as(user, scope: :user)
    visit seller_path
  end

  it 'is successfully removed' do
    click_on('Dropdown')
    click_on('Destroy')
    expect(page).to have_content I18n.t('messages.destroyed', name: 'Listing')
  end
end
