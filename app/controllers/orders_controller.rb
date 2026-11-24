class OrdersController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  def index
    @orders = Order.by_created_at.with_line_items
  end

  def show
    @order = Order.with_line_items.find(params[:id])
    @order.update(viewed: true)
  end

  def new
    @order = Order.new
    render_new
  end

  def create
    @order = Order.new(order_params.merge(basket: current_basket))
    place_order
    redirect_to root_url, flash: { partial: "thank_you" }
  rescue ActiveRecord::RecordInvalid
    render_new
  end

  private

  # Saves the order, charges for it, and swaps the basket in the session for
  # the order, so the home page can thank the customer for it.
  def place_order
    @order.save!
    OrderBuilder.build(@order, params[:stripe_token])
    session[:basket_id] = nil
    session[:order_id] = @order.id
  end

  def order_params
    params.require(:order).permit(
      :address_line_1, :address_line_2, :address_city, :address_post_code,
      :address_county, :email, :name
    )
  end

  def render_new
    return render(:new) if current_basket.line_items.any?

    redirect_to(shop_url, notice: t("orders.new.notice"))
  end
end
