class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    if @basket.line_items.empty?
      flash[:notice] = 'Your cart is empty.'
      redirect_to(products_path)
    end

    @title = 'New order'
    @order = Order.new
  end

  def show
    @order = OrderDecorator.find(params[:id])
  end

  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_basket(@basket)

    if @order.save
      Basket.destroy(session[:basket_id])
      session[:basket_id] = nil
      flash[:success] = 'Thank you for your order.'
      redirect_to(products_path)
    else
      @title = 'New order'
      render(action: 'new')
    end
  end
end
