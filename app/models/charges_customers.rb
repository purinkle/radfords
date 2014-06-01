class ChargesCustomers
  def initialize(email, card, amount, order_id)
    @email = email
    @card = card
    @amount = amount
    @order_id = order_id
  end

  def charge
    Stripe::Charge.create(
      amount: amount,
      currency: 'gbp',
      customer: customer_id,
      description: description
    )
  end

  def self.charge(email, card, amount, order_id)
    new(email, card, amount, order_id).charge
  end

  private

  attr_reader :amount, :card, :email, :order_id

  def customer
    Stripe::Customer.create(card: card, email: email)
  end

  def description
    "Payment for ##{order_id}"
  end

  def customer_id
    customer.id
  end
end
