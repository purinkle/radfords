class OrdersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @order = Order.new
    render_new
  end

  def create
    @order = Order.new(order_options)
    build_order
    redirect_to root_url, flash: { partial: "thank_you" }
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  def show
    @order = Order.find(params[:id])
    @order.update_attribute(:viewed, true)
  end

  def index
    @orders = Order.by_created_at
  end

  private

  def build_order
    order.save!
    OrderBuilder.build(order, stripe_token)
    clear_session
  end

  def clear_session
    session[:basket_id] = nil
    session[:order_id] = order.id
  end

  def order
    @order
  end

  def order_options
    order_params.merge(basket: current_basket)
  end

  def order_params
    params.require(:order).permit(
      :address_line_1,
      :address_line_2,
      :address_city,
      :address_post_code,
      :address_county,
      :email,
      :name
    )
  end

  def render_new
    if current_basket.line_items.empty?
      redirect_to(shop_url, notice: t("orders.new.notice"))
      return
    end

    render action: :new
  end

  def stripe_token
    params[:stripe_token]
  end
end
