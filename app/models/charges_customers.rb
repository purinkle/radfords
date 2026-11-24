# Takes payment through Stripe, creating a customer for the card first.
class ChargesCustomers
  def self.charge(email, card, amount, order_id)
    customer = Stripe::Customer.create(card: card, description: "Customer for ##{order_id}", email: email)
    Stripe::Charge.create(
      amount: amount, currency: "gbp", customer: customer.id, description: "Payment for ##{order_id}"
    )
  end
end
