class WinningBidsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_auction

  def create
    @winning_bid = WinningBid.new winning_bid_params
    @winning_bid.auction = @auction
    @winning_bid.user = current_user
    if @winning_bid.save
      if current_user.stripe_customer_token.nil?
        redirect_to new_winning_bid_payment_path(@winning_bid)
      else
        service = Payment::BidAgainWithStripe.new(
                    user: current_user,
                    winning_bid: @winning_bid
                  )
        if service.call
          redirect_to @winning_bid.auction, notice: "Thanks for your payment."
        else
          @error_message = "Sorry! Something went wrong. Try again."
          render :new
        end
      end
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
