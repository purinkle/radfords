class BasketsController < ApplicationController
  skip_before_filter :authenticate

  def show
    @basket = BasketDecorator.new(FindBasket.call(id: session["basket_id"]))
  end

  def destroy
    @basket = current_basket
    @basket.destroy
    session[:basket_id] = nil
    redirect_to shop_url, notice: t('baskets.destroy.notice')
  end
end
