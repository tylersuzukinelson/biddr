class AuctionsController < ApplicationController

  before_action :get_auction, only: [:show, :edit, :update, :destroy]

  def index
    @auctions = Auction.order(end_date: :desc)
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new auction_params
    if @auction.save
      redirect_to @auction
    else
      flash[:alert] = get_errors
      render :new
    end
  end

  def show
    @bid = Bid.new
  end

  def edit
  end

  def update
    if @auction.update auction_params
      redirect_to @auction
    else
      flash[:alert] = get_errors
      render :edit
    end
  end

  def destroy
    if @auction.destroy
      redirect_to auctions_path
    else
      flash[:alert]
      render :show
    end
  end

  private

  def get_auction
    @auction = Auction.find params[:id]
  end

  def auction_params
    params.require(:auction).permit(:name, :details, :end_date, :reserve_price)
  end

  def get_errors
    @auction.errors.full_messages.join('; ')
  end

end
