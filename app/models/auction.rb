class Auction < ActiveRecord::Base

  include AASM

  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :bids_users, through: :bids, source: :user
  has_one :winning_bid

  validates :name, presence: true

  aasm do
    state :published, initial: true
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end
  end

  def current_price
    unless bids.empty?
      bids.order(price: :desc).first.price + 1 || 0
    else
      0
    end
  end

  def highest_bid
    bids.order(price: :desc).first if aasm_state == "reserve_met"
  end

  def highest_bidder
    @highest_bid = highest_bid
    @highest_bid.user if @highest_bid
  end

end
