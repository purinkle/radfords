module ApplicationHelper
  def flash_message_class(type)
    { 'alert' => 'error', 'notice' => 'success' }.fetch(type, 'info')
  end

  def humanize_price(price)
    humanized_money_with_symbol(price, no_cents_if_whole: false)
  end

  def title
    "#{content_for(:title).presence || @title} | Radfords of Somerford"
  end

  def nav_class(controller_name)
    if controller_name == controller.controller_name
      "active"
    end
  end

  def navbar
    if signed_in?
      render(partial: "shared/navbar")
    end
  end
end
