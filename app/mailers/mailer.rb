class Mailer < ActionMailer::Base
  def order_received(order)
    @order = order

    mail(from: 'noreply@example.com', to: order.email, subject: t('.subject'))
  end

  def order_shipped(order)
    @order = order
    mail(
      from: 'denise@radfordsofsomerford.co.uk',
      subject: t('.subject'),
      to: @order.email
    )
  end
end
