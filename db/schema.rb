# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150227180804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auctions", force: :cascade do |t|
    t.string   "name"
    t.text     "details"
    t.datetime "end_date"
    t.float    "reserve_price"
    t.string   "aasm_state"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "bids", force: :cascade do |t|
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "auction_id"
  end

  add_index "bids", ["auction_id"], name: "index_bids_on_auction_id", using: :btree

  add_foreign_key "bids", "auctions"
end
