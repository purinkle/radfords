class Mailer < ActionMailer::Base
  def order_received(order)
    @order = order
    mail(
      from: 'Radfords <denise@radfordsofsomerford.co.uk>',
      subject: t('.subject'),
      to: @order.email
    )
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
