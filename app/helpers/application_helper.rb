module ApplicationHelper
  
  def title
    base_title = "Radfords of Somerford"
    
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
