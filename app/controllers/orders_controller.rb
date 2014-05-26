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

    ChargesCustomers.charge(email, stripe_token, amount)

    @order.add_line_items_from_basket(current_basket)

    if @order.save
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

  def amount
    total_price.cents
  end

  def email
    params[:email]
  end

  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def stripe_token
    params[:stripe_token]
  end

  def total_price
    current_basket.total_price
  end
end
