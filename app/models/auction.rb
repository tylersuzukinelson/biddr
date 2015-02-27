class Auction < ActiveRecord::Base

  validates :name, presence: true

end
