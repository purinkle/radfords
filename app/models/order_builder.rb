class OrderBuilder
  def initialize(order, stripe_token)
    @order = order
    @stripe_token = stripe_token
  end

  def build
    ChargesCustomers.charge(email, stripe_token, price, id)
    mailer.deliver_now
  end

  def self.build(order, stripe_token)
    new(order, stripe_token).build
  end

  private

  attr_reader :order, :stripe_token

  def email
    order.email
  end

  def id
    order.id
  end

  def mailer
    Mailer.order_received(order)
  end

  def price
    total_price.cents
  end

  def total_price
    order.total_price
  end
end
