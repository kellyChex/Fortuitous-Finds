require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before :each do
    @user = create(:user)
    @listing = create(:listing, user: @user)
    sign_in @user
    request.env["HTTP_REFERER"] = '/'
  end

  describe 'GET #search' do
    context 'with valid attributes' do
      it 'assigns the search to search_string' do

        get :search, search_string: @listing.name
        expect(assigns(:search)).to eq([@listing])
      end

      it 'renders the search view' do
        get :search, search_string: @listing.name
        expect(response).to render_template('pages/search')
      end
    end

    context 'with invalid attributes' do
      it 'assigns the search to @search' do
        @search = nil
        get :search, @search
        expect(assigns(:search_string)).to eq(nil)
      end

      it 'renders the search view' do
        @search = nil
        get :search, @search
        expect(response).to redirect_to '/'
      end
    end
  end
end
