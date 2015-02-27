class PaymentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_winning_bid

  def new
  end

  def create
    service = Payment::CreateWithStripe.new(
                user: current_user,
                winning_bid: @winning_bid,
                stripe_token: params[:stripe_token]
              )
    if service.call
      redirect_to @winning_bid.auction, notice: "Thanks for your payment."
    else
      @error_message = "Sorry! Something went wrong. Try again."
      render :new
    end
  end

  private

  def find_winning_bid
    @winning_bid = current_user.winning_bids.find params[:winning_bid_id]
  end

end
