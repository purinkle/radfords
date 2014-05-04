class OrdersController < ApplicationController
  skip_before_filter :authenticate

  def new
    if current_basket.line_items.empty?
      redirect_to(shop_url, notice: t('orders.new.notice'))
      return
    end

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_basket(current_basket)

    if @order.save
      Basket.destroy(session[:basket_id])
      session[:basket_id] = nil
      Rails.logger.error "#{'*' * 10} [order] #{@order.inspect}"
      Mailer.order_received(@order).deliver
      redirect_to shop_url, notice: 'Thank you for your order.'
    else
      render action: "new"
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
