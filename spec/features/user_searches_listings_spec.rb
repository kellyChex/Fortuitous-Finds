require 'rails_helper'

RSpec.feature 'User searches listings', :js do
  let!(:user1)          { create(:user, name: 'Billy') }
  let!(:user2)          { create(:user, name: 'Mary') }
  let!(:listing1_user1) { create(:listing, name: 'Rug', user: user1) }
  let!(:listing2_user1) { create(:listing, name: 'Ball', user: user1) }
  let!(:listing1_user2) { create(:listing, name: 'Rug', user: user2) }
  let!(:listing2_user2) { create(:listing, name: 'Bike', user: user2) }

  background do
    visit root_path
  end

  context 'by listing name' do
    before do
      fill_in 'word_search_input', with: 'Rug'
      find(:css, '.glyphicon-search').click
    end

    it 'displays all listings with that listing name' do
      expect(page).to have_content(listing1_user1.name)
      expect(page).to have_content(listing1_user2.name)
    end

    it 'does not display listings that do not have that listing name' do
      expect(page).to_not have_content(listing2_user1.name)
      expect(page).to_not have_content(listing2_user2.name)
    end
  end

  context 'by user name' do
    before do
      fill_in 'word_search_input', with: 'Billy'
      find(:css, '.glyphicon-search').click
    end

    it 'displays all listings under that user' do
      expect(page).to have_content(listing1_user1.name)
      expect(page).to have_content(listing2_user1.name)
    end

    it "does not display listings that do not contain the user's name" do
      expect(page).to_not have_content(listing1_user2.user.name)
      expect(page).to_not have_content(listing2_user2.name)
    end
  end
end
