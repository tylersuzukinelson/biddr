class Bid < ActiveRecord::Base
  belongs_to :auction

  validates :price, presence: true
end
