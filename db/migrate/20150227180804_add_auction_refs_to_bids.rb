class AddAuctionRefsToBids < ActiveRecord::Migration
  def change
    add_reference :bids, :auction, index: true
    add_foreign_key :bids, :auctions
  end
end
