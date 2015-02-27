class AddUserRefsToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :user, index: true
    add_foreign_key :auctions, :users
  end
end
