class Auction < ActiveRecord::Base

  include AASM

  has_many :bids, dependent: :destroy

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

end
