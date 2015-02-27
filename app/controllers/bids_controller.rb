class BidsController < ApplicationController

  def create
    @bid = Bid.new bid_params
    @auction = Auction.find params[:auction_id]
    @bid.auction = @auction
    if @bid.save
      redirect_to @auction
    else
      flash[:alert] = get_errors
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
