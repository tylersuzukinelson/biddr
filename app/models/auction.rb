class Auction < ActiveRecord::Base

  has_many :bids, dependent: :destroy

  validates :name, presence: true

  def current_price
    unless bids.empty?
      bids.order(price: :desc).first.price + 1 || 0
    else
      0
    end
  end

end
