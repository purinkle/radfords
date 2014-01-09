class Mailer < ActionMailer::Base
  def order_received(order)
    @order = order

    mail(from: 'noreply@example.com', to: order.email, subject: t('.subject'))
  end
end
