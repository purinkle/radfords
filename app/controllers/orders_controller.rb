class OrdersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @order = OrderForm.new
    render_new
  end

  def create
    @order = OrderForm.new(order_params)

    if @order.save
      clear_session
      redirect_to root_url, flash: { partial: "thank_you" }
    else
      render_new
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

  def clear_session
    session[:basket_id] = nil
    session[:order_id] = order.id
  end

  def order
    @order
  end

  def order_params
    params.require(:order).permit(
      :address_city,
      :address_county,
      :address_line_1,
      :address_line_2,
      :address_post_code,
      :card_number,
      :card_cvc,
      :email,
      :card_exp_month,
      :card_exp_year,
      :name,
    ).merge(basket: current_basket)
  end

  def render_new
    if current_basket.line_items.empty?
      redirect_to(shop_url, notice: t("orders.new.notice"))
      return
    end

    render action: :new
  end
end
