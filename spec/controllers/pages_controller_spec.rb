require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  before :each do
    @user = create(:user, name: 'Kat')
    @user2 = create(:user, name: 'Billy')
    @listing1 = create(:listing, name: 'Rug', user: @user)
    @listing2 = create(:listing, name: 'Car', user: @user)
    @user2_listing = create(:listing, name: 'Surfboard', user: @user2)
    sign_in @user
  end

  describe 'GET #search' do
    context 'with valid attributes' do
      it 'assigns the search to @search' do
        search = @search
        get :search, @search
        expect(assigns(:search_string)).to eq(search)
      end

      it 'renders the search view' do
        search = @search
        get :search, @search
        expect(response).to render_template('pages/search', 'layouts/application')
      end
    end

    context 'with invalid attributes' do
      it 'assigns the search to @search' do
        search = @search
        get :search, @search
        expect(assigns(:search_string)).to eq(search)
      end

      it 'renders the search view' do
        search = @search
        get :search, @search
        expect(response).to render_template('pages/search', 'layouts/application')
      end
    end
  end
end
