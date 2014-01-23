class PagesController < ApplicationController
  skip_before_filter :authenticate

  def home
    @events = Event.limit(3)
    @products = Product.page(params[:page])
  end

  def products
    @products = Product.all
  end

  def outlets
    @title = "Outlets"
    @suppliers = Supplier.all
  end

  def contact; end
end
