class Payment::CreateWithStripe

  include Virtus.model

  attribute :winning_bid, WinningBid
  attribute :user, User
  attribute :stripe_token, String

  attribute :customer
  attribute :error_messages, Array

  def call
    create_customer && save_user_data && charge_user
  end

  private

  def create_customer
    begin
      @customer = Stripe::Customer.create(
        description: "Customer for #{user.email}",
        source: stripe_token
      )
    rescue => e
      @error_messages << e.message
      false
    end
  end

  def save_user_data
    user.stripe_customer_token = customer.id
    user.stripe_last4 = customer.sources.data[0].last4
    user.stripe_card_type = customer.sources.data[0].brand
    user.save
  end

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