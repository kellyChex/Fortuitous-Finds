require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

  describe 'user access' do
    before :each do
      @user = create(:user)
      @user2 = create(:user)
      sign_in @user
    end

    describe 'listing#seller' do
      it "assigns all of sellers' listings in descending order" do
        listing1 = create(:listing, created_at: '12/22/2014',
          user: @user)
        listing2 = create(:listing, created_at: '12/25/2014',
          user: @user)
        listing3 = create(:listing, created_at: '12/25/2014',
          user: @user2)
        get :seller, user: @user
        expect(assigns(:listings)).to match([listing2, listing1])
      end

      it 'renders the :seller view' do
        get :seller
        expect(response).to render_template :seller
      end
    end

    describe 'GET #index' do
      it 'assigns all listings in descending order' do
        old_listing = create(:listing, created_at: '12/22/2014')
        new_listing = create(:listing, created_at: '12/25/2014')
        get :index
        expect(assigns(:listings)).to match([new_listing, old_listing])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      it 'assigns the requested order as @listing' do
        listing = create(:listing)
        get :show, id: listing
        expect(assigns(:listing)).to eq(listing)
      end

      it 'renders the :show template' do
        listing = create(:listing)
        get :show, id: listing
        expect(response).to render_template :show
      end
    end

    describe 'POST #create' do
      context 'with valid attribute' do
        it 'saves the new listing in the database' do
          expect{ post :create, listing: attributes_for(:listing) }.
            to change(Listing, :count).by(1)
          end

        it 'redirects to contacts#show' do
          post :create, listing: attributes_for(:listing)
          expect(response).to redirect_to(listing_path(assigns[:listing]))
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new listing in the database' do
          expect{ post :create, listing: attributes_for(:invalid_listing) }.
            to_not change(Listing, :count)
        end

        it 're-renders the :new template' do
          post :create, listing: attributes_for(:invalid_listing)
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      before :each do
        @listing = create(:listing, user: @user)
        @listing2 = create(:listing, user: @user2)
      end

      context 'the listing user is not the current user' do
        it 'located the requested @listing' do
          patch :update, id: @listing2, listing: attributes_for(:listing)
          expect(assigns(:listing)).to eq(@listing2)
        end

        it 'redirects to the root url' do
          patch :update, id: @listing2, listing: attributes_for(:listing)
          expect(response).to redirect_to root_url
        end
      end

      context 'valid attributes' do
        it 'located the requested @listing' do
          patch :update, id: @listing, listing: attributes_for(:listing)
          expect(assigns(:listing)).to eq(@listing)
        end

        it "changes @listing's attributes" do
          patch :update, id: @listing,
            listing: attributes_for(:listing, name: 'Yoga Ball',
              description: 'Purple', price: 10.00)
          @listing.reload
          expect(@listing.name).to eq('Yoga Ball')
          expect(@listing.description).to eq('Purple')
          expect(@listing.price).to eq(10.00)
        end

        it 'redirects to the updated listing' do
          patch :update, id: @listing, listing: attributes_for(:listing)
          expect(response).to redirect_to @listing
        end
      end

      context 'with invalid attributes' do
        it "does not change the contact's attributes" do
          patch :update, id: @listing,
            listing: attributes_for(:invalid_listing)
          @listing.reload
          expect(@listing.name).to eq('Lamp')
          expect(@listing.description).to eq('Found in the Cave of Wonders')
          expect(@listing.price).to eq(100000000.00)
        end

        it 're-renders the edit template' do
          patch :update, id: @listing, listing: attributes_for(:invalid_listing)
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE destroy' do
      before :each do
        @listing = create(:listing, user: @user)
        @listing2 = create(:listing, user: @user2)
      end

      context 'the listing user is not the current user' do
        it 'located the requested @listing' do
          delete :destroy, id: @listing2
          expect(assigns(:listing)).to eq(@listing2)
        end

        it 'redirects to the root url' do
          patch :update, id: @listing2, listing: attributes_for(:listing)
          expect(response).to redirect_to root_url
        end
      end

      it 'deletes the listing' do
        expect{ delete :destroy, id: @listing }.to change(Listing, :count).by(-1)
      end

      it 'redirects to listings#index' do
        delete :destroy, id: @listing
        expect(response).to redirect_to listings_url
      end
    end
  end
end
