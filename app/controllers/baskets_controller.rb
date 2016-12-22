class BasketsController < ApplicationController
  skip_before_action :authenticate

  def show
    @basket = BasketDecorator.new(FindBasket.call(id: session["basket_id"]))
  end

  def destroy
    @basket = current_basket
    @basket.destroy
    session[:basket_id] = nil
    redirect_to basket_url, notice: t("baskets.destroy.notice")
  end
end
