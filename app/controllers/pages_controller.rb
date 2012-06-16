class PagesController < ApplicationController
  def home
    @title = "Home"
    @events = Event.find(:all, limit: 3 )
  end

  def products
    @title = "Products"
  end

  def outlets
    @title = "Outlets"
    @suppliers = Supplier.all
  end

  def contact
    @title = "Contact"
  end

end
