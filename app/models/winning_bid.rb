class WinningBid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :price, numericality: { greater_than: 0 }
  validates :auction, uniqueness: true
end
