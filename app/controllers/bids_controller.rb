class BidsController < ApplicationController

  before_action :authenticate_user!

  def create
    @bid = Bid.new bid_params
    @auction = Auction.find params[:auction_id]
    @bid.auction = @auction
    begin
      ActiveRecord::Base.transaction do
        @bid.save!
        @auction.meet_reserve! if @bid.price >= @auction.reserve_price
      end
      redirect_to @auction
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.message
      redirect_to @auction
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:price)
  end

  def get_errors
    @bid.errors.full_messages.join('; ')
  end

end
