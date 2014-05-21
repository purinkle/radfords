class FulfilmentsController < ApplicationController
  def create
    Mailer.order_shipped(order).deliver
    redirect_to(order)
  end

  private

  def order
    @order ||= Order.find(order_id)
  end

  def order_id
    params[:order_id]
  end
end
