module ApplicationHelper

  def title
    base_title = "Radfords of Somerford"
    @title = content_for(:title).presence || @title

    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
