require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:auction) { create(:auction) }
  let(:auction_1) { create(:auction) }

  describe "#index" do
    it "assigns an auctions instance" do
      get :index
      expect(assigns(:auctions)).to eq([auction, auction_1])
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#create" do
    context "with valid request" do
      def valid_request
        post :create, { auction: {
            name: 'New auction',
            details: 'These are the details',
            end_date: DateTime.current + 3.days,
            reserve_price: 50
          } }
      end
      it "creates a new auction record in the database" do
        expect{ valid_request }.to change{ Auction.count }.by(1)
      end
      it "redirects to the show page" do
        valid_request
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end
    context "with invalid request" do
      def invalid_request
          post :create, { auction: {
            name: '',
            details: 'These are the details',
            end_date: DateTime.current + 3.days,
            reserve_price: 50
          } }
      end
      it "doesn't create a new auction record" do
        expect{ invalid_request }.to change{ Auction.count }.by(0)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#new" do
    before {
      get :new
    }
    it "assigns a new auction instance" do
      expect(assigns(:auction)).to be_a_new(Auction)
    end
    it "renders the new template" do
      expect(response).to render_template(:new)
    end
  end

  describe "#edit" do
    before {
      get :edit, id: auction.id
    }
    it "assigns an auction instance as per the passed id" do
      expect(assigns(:auction)).to eq(auction)
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#show" do
    before {
      get :show, id: auction.id
    }
    it "assigns a auction instance as per the passed id" do
      expect(assigns(:auction)).to eq(auction)
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "#update" do
    context "with valid request" do
      before do
        patch :update, id: auction.id, auction: {
            name: 'New auction name',
            details: 'New auction details'
          }
      end
      it "changes the name of the auction in the database" do
        auction.reload
        expect(auction.name).to eq('New auction name')
      end
      it "redirects to the show page" do
        expect(response).to redirect_to(auction_path(auction))
      end
    end
    context "with invalid request" do
      before do
        patch :update, id: auction.id, auction: {
            name: '',
            details: 'New auction details'
          }
      end
      it "doesn't change the name of the auction in the database" do
        auction.reload
        expect(auction.name).not_to eq('')
      end
      it "renders the edit page" do
        expect(response).to render_template(:edit)
      end
      it "sets a flash alert message" do
        expect(flash[:alert]).to be
      end
    end
  end

  describe "#destroy" do
    let!(:auction) { create(:auction) }
    def destroy_request
      delete :destroy, id: auction.id
    end
    it "deletes the auction from the database" do
      expect{ destroy_request }.to change{ Auction.count }.by(-1)
    end
    it "redirects to the index page" do
      destroy_request
      expect(response).to redirect_to(auctions_path)
    end
  end

end