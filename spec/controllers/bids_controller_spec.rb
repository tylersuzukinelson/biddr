require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:auction) { create(:auction) }

  describe "#create" do
    context "with valid request" do
      def valid_request
        post :create, { auction_id: auction.id,
                        bid: {
                          price: 100
                        }
                      }
      end
      it "creates a new bid record in the database" do
        expect{ valid_request }.to change{ Bid.count }.by(1)
      end
      it "is associated with the auction" do
        valid_request
        expect(Bid.last.auction).to eq(auction)
      end
      it "redirects to the auction show page" do
        valid_request
        expect(response).to redirect_to(auction_path(auction))
      end
    end
    context "with invalid request" do
      def invalid_request
          post :create, { auction_id: auction.id,
                          bid: {
                            price: nil
                          }
                        }
      end
      it "doesn't create a new bid record" do
        expect{ invalid_request }.to change{ Bid.count }.by(0)
      end
      it "redirects to the auction show page" do
        invalid_request
        expect(response).to redirect_to(auction_path(auction))
      end
      it "sets a flash alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
