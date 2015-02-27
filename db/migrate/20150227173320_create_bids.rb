class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.float :price

      t.timestamps null: false
    end
  end
end
