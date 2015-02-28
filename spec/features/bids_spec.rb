require 'rails_helper'

RSpec.feature "Bids", type: :feature do
  describe "#create" do
    let(:user) { create(:user) }
    let(:auction) { create(:auction) }
    context "with valid request" do
      it "shows the user's bid in the bid listing" do
        login_via_web(user)
        visit auction_path(auction)
        fill_in "Price", with: "5"
        click_button "Bid"
        expect(page).to have_content "$5.00 by"
      end
    end
    context "with invalid request" do
      it "prevents the user from bidding on their own auction" do
        login_via_web(user)
        visit '/auctions/new'
        fill_in "Name", with: "Test Name"
        click_button "Create Auction"
        visit auction_path(Auction.last)
        fill_in "Price", with: "5"
        click_button "Bid"
        expect(page).to have_content "You cannot bid on your own auction"
      end
    end
  end
end