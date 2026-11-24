module ApplicationHelper
  def humanize_price(price)
    humanized_money_with_symbol(price, no_cents_if_whole: false)
  end

  def nav_class(controller_name)
    return unless controller_name == controller.controller_name

    "active"
  end

  def navbar
    return unless signed_in?

    render(partial: "shared/navbar")
  end
end
