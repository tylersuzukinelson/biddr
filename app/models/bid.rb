class Bid < ActiveRecord::Base

  belongs_to :auction

  validates :price, numericality: { greater_than: 0 }

  before_validation :check_price

  private

  def check_price
    if (price.is_a? Numeric) && (price <= auction.current_price)
      errors.add(:price, "must be higher than the auction's current price")
    end
  end

end
