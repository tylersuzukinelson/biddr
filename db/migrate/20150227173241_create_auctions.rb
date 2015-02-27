class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :name
      t.text :details
      t.datetime :end_date
      t.float :reserve_price
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
