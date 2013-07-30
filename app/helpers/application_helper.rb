module ApplicationHelper
  def flash_message_class(type)
    if type == :alert
      'error'
    elsif type == :notice
      'success'
    else
      'info'
    end
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

  def sign_in_link
    unless signed_in?
      render "layouts/sign_in_link"
    end
  end
end
