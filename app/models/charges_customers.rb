class ChargesCustomers
  def initialize(email, card, amount)
    @email = email
    @card = card
    @amount = amount
  end

  def charge
    Stripe::Charge.create(
      amount: amount,
      currency: 'gbp',
      customer: customer_id,
      description: description
    )
  end

  def self.charge(email, card, amount)
    new(email, card, amount).charge
  end

  private

  attr_reader :amount, :card, :email

  def customer
    Stripe::Customer.create(card: card, email: email)
  end

  def description
    "Order for #{email}"
  end

  def customer_id
    customer.id
  end
end
