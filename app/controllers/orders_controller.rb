class OrdersController < ApplicationController
  def new
    if @basket.line_items.empty?
      flash[:notice] = 'Your cart is empty.'
      redirect_to(products_path)
    end

    @title = 'New order'
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_basket(@basket)

    if @order.save
      Basket.destroy(session[:basket_id])
      session[:basket_id] = nil
      redirect_to(products_path, notice: 'Thank you for your order.')
    else
      @title = 'New order'
      render(action: 'new')
    end
  end
end
