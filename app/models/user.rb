class User < ActiveRecord::Base

  has_secure_password

  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :bid_auctions, through: :bids, source: :auction
  has_many :winning_bids, dependent: :destroy
  has_many :auctions_won, through: :winning_bids, source: :auction

  validates :email, presence: true, email: true

end
