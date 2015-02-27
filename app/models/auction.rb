class Auction < ActiveRecord::Base

  has_many :bids, dependent: :destroy

  validates :name, presence: true

end
