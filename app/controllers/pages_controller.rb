class PagesController < ApplicationController
  skip_before_action :authenticate

  def home
    @events = Event.limit(3)

    order_id = session.delete(:order_id)
    @order = Order.with_line_items.find(order_id) if order_id

    @products = Product.with_attached_photo.page(params[:page])
  end

  def products
    @products = Product.with_attached_photo
  end

  def outlets
    @title = "Outlets"
    @suppliers = Supplier.all
  end

  def contact; end
end
