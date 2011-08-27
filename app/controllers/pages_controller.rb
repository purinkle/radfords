class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def products
    @title = "Products"
  end
  
  def outlets
    @title = "Outlets"
  end
  
  def contact
    @title = "Contact"
  end

end
