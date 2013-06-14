class PagesController < ApplicationController
  skip_before_filter :authenticate

  def home
    @title = "Home"
    @events = Event.find(:all, limit: 3 )
  end

  def products
    @products = Product.all
  end

  def outlets
    @title = "Outlets"
    @suppliers = Supplier.all
  end

  def contact
    @title = "Contact"
  end

end
