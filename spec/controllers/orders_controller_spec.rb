require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before :each do
    @user = create(:user)
    @user2 = create(:user)
    @listing1 = create(:listing, user: @user)
    @listing2 = create(:listing, user: @user)
    @user2_listing = create(:listing, user: @user2)
    sign_in @user
  end

  describe 'GET #new' do
    it 'assigns a new order to @order' do
      get :new, listing_id: @listing1.id
      expect(assigns(:order)).to be_a_new(Order)
    end

    it 'renders the :new template' do
      get :new, listing_id: @listing1.id
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new order in the database' do
        expect{ post :create, order: attributes_for(:order),
          listing_id: @listing1.id }.to change(Order, :count).by(1)
      end
    end

      it 'redirects to root url' do
        post :create, order: attributes_for(:order), listing_id: @listing1.id
        expect(response).to redirect_to(root_url)
      end

    context 'with invalid attributes' do
      it 'does not save the new order in the database' do
        expect{ post :create, order: attributes_for(:invalid_order),
          listing_id: @listing1.id }.to_not change(Order, :count)
      end

      it 're-renders the :new template' do
        post :create, order: attributes_for(:invalid_order),
          listing_id: @listing1.id
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #sellers_sales' do
    it "assigns all of the seller's sales in descending order" do
      old_order = create(:order, seller: @user, created_at: '12/22/2014',
        listing_id: @listing2.id)
      new_order = create(:order, seller: @user, created_at: '12/25/2014',
        listing_id: @listing1.id)
      diff_order = create(:order, seller: @user2, created_at: '12/26/2014',
        listing_id: @user2_listing.id)
      get :sellers_sales

      expect(assigns(:orders)).to match([new_order, old_order])
    end
  end

  describe 'GET #purchases' do
    it "assigns all of the buyer's purchases" do
      old_order = create(:order, buyer: @user, created_at: '12/22/2014',
        listing_id: @listing2.id)
      new_order = create(:order, buyer: @user, created_at: '12/25/2014',
        listing_id: @listing1.id)
      diff_order = create(:order, buyer: @user2, created_at: '12/26/2014',
        listing_id: @user2_listing.id)
      get :buyers_purchases

      expect(assigns(:orders)).to match([new_order, old_order])
    end
  end
end
