class Payment::BidAgainWithStripe

  include Virtus.model

  attribute :winning_bid, WinningBid
  attribute :user, User

  attribute :error_messages, Array

  def call
    charge_user
  end

  private

  def charge_user
    begin
      # charge the customer
      Stripe::Charge.create(
        amount: (winning_bid.price * 100).to_i,
        currency: 'cad',
        customer: user.stripe_customer_token,
        description: "Payment for auction: #{winning_bid.auction.name}"
      )
    rescue => e
      @error_messages << e.message
      false
    end
  end

end