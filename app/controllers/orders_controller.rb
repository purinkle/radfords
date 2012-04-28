class OrdersController < ApplicationController
  def new
    @title = 'New order'
    @order = Order.new
  end
end
