class BidsController < ApplicationController

  before_action :authenticate_user!

  def create
    @bid = Bid.new bid_params
    @auction = Auction.find params[:auction_id]
    @bid.auction = @auction
    @bid.user = current_user
    respond_to do |format|
      if @auction.user == current_user
        format.html { redirect_to @auction, alert: "You cannot bid on your own auction!" }
        format.js {
          @bid.errors.add(:user, "owns this auction! You cannot bid on your own auction")
          render
        }
      else
        begin
          ActiveRecord::Base.transaction do
            @bid.save!
            unless @auction.aasm_state == 'reserve_met'
              @auction.meet_reserve! if @bid.price >= @auction.reserve_price
            end
          end
          format.html { redirect_to @auction }
          format.js { render }
        rescue ActiveRecord::RecordInvalid => e
          format.html { redirect_to @auction, alert: e.message }
          format.js { 
            @bid.errors.add(:base, get_errors)
            render
          }
        end
      end
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
