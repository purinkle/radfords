class BasketsController < ApplicationController
  skip_before_filter :authenticate

  def show
    @basket = Basket.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to shop_url, alert: t('baskets.show.alert')
  end

  def destroy
    @basket = current_basket
    @basket.destroy
    session[:basket_id] = nil
    redirect_to shop_url, notice: t('baskets.destroy.notice')
  end
end
