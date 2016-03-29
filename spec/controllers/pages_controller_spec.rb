require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before :each do
    @user = create(:user, name: 'Kat')
    @user2 = create(:user, name: 'Billy')
    @listing1 = create(:listing, name: 'Rug', user: @user)
    @listing2 = create(:listing, name: 'Car', user: @user)
    @user2_listing = create(:listing, name: 'Surfboard', user: @user2)
    sign_in @user
    request.env["HTTP_REFERER"] = '/'
  end

  describe 'GET #search' do
    context 'with valid attributes' do
      it 'assigns the search to search_string' do

        get :search, search_string: @listing1.name
        expect(assigns(:search)).to eq([@listing1])
      end

      it 'renders the search view' do
        get :search, search_string: @listing1.name
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
