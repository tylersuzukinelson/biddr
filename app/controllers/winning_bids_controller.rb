class WinningBidsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_auction

  def create
    @winning_bid = WinningBid.new winning_bid_params
    @winning_bid.auction = @auction
    @winning_bid.user = current_user
    if @winning_bid.save
      redirect_to new_winning_bid_payment_path(@winning_bid)
    else
      redirect_to @auction, alert: get_errors
    end
  end

  private

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def winning_bid_params
    params.require(:winning_bid).permit(:price)
  end

  def get_errors
    @winning_bid.errors.full_messages.join('; ')
  end

end
