class OrdersController < ApplicationController
  def new
    if @basket.line_items.empty?
      flash[:notice] = 'Your cart is empty.'
      redirect_to(products_path)
    end

    @title = 'New order'
    @order = Order.new
  end
end
