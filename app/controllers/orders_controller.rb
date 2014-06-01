class OrdersController < ApplicationController
  skip_before_filter :authenticate, only: [:new, :create]

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
      ChargesCustomers.charge(
        email,
        stripe_token,
        @order.total_price.cents,
        @order.id
      )
      Basket.destroy(session[:basket_id])
      session[:basket_id] = nil
      session[:order_id] = @order.id
      Mailer.order_received(@order).deliver
      redirect_to root_url, flash: { partial: 'thank_you' }
    else
      render action: "new"
    end
  end

  def show
    @order = Order.find(params[:id])
    @order.update_attribute(:viewed, true)
  end

  def index
    @orders = Order.by_created_at
  end

  private

  def email
    params[:email]
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def stripe_token
    params[:stripe_token]
  end
end
