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
    base_title = "Radfords of Somerford"
    @title = content_for(:title).presence || @title

    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end

  def navbar(&block)
    return unless signed_in?

    content_tag :div, class: 'navbar' do
      content_tag :div, class: 'navbar-inner' do
        link_to('Radfords', root_path, class: 'brand') +
        capture(&block)
      end
    end
  end

  def nav_item(body, url, controller_name)
    klass = 'active' if controller.controller_name == controller_name

    content_tag :li, class: klass do
      link_to(body, url)
    end
  end
end
