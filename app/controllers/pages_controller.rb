class PagesController < ApplicationController
  skip_before_filter :authenticate

  def home
    @basket = basket
    @events = Event.limit(3)

    if session[:order_id]
      @order = Order.find(session[:order_id])
      session[:order_id] = nil
    end

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

  private

  def basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    NullBasket.new
  end
end
