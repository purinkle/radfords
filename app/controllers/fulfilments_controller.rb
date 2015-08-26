class FulfilmentsController < ApplicationController
  def create
    Mailer.order_shipped(order).deliver_now
    redirect_to(order, notice: t('fulfilments.create.notice'))
  end

  private

  def order
    @order ||= Order.find(order_id)
  end

  def order_id
    params[:order_id]
  end
end
