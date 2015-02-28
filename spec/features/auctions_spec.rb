require 'rails_helper'

RSpec.feature "Auctions", type: :feature do
  describe "#create" do
    let(:user) { create(:user) }
    context "with valid request" do
      it "redirects the user to the show page for that auction" do
        login_via_web(user)
        visit '/auctions/new'
        fill_in "Name", with: "Test Name"
        click_button "Create Auction"
        expect(page).to have_content "Current Price"
      end
    end
    context "with invalid request" do
      it "renders the new template" do
        login_via_web(user)
        visit '/auctions/new'
        click_button "Create Auction"
        expect(page).to have_content "Name can't be blank"
      end
    end
  end
end