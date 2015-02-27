class CreateWinningBids < ActiveRecord::Migration
  def change
    create_table :winning_bids do |t|
      t.float :price
      t.string :stripe_txn_id
      t.references :user, index: true
      t.references :auction, index: true

      t.timestamps null: false
    end
    add_foreign_key :winning_bids, :users
    add_foreign_key :winning_bids, :auctions
  end
end
