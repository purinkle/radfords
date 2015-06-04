class Mailer < ActionMailer::Base
  def order_received(order)
    @order = order
    mail(
      from: "Radfords <#{denise}>",
      subject: t(".subject", id: @order.id),
      to: [@order.email, denise]
    )
  end

  def order_shipped(order)
    @order = order
    mail(
      from: 'denise@radfordsofsomerford.co.uk',
      subject: t(".subject", id: @order.id),
      to: @order.email
    )
  end

  private

  def denise
    "denise@radfordsofsomerford.co.uk"
  end
end
