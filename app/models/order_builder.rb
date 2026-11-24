# Charges the customer for a saved order, then emails them a receipt.
class OrderBuilder
  def self.build(order, stripe_token)
    ChargesCustomers.charge(order.email, stripe_token, order.total_price.cents, order.id)
    Mailer.order_received(order).deliver_now
  end
end
