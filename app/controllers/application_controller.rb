class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  before_filter :basket

  def basket
    @basket = current_basket
  end

  private

  def current_basket
    Basket.find(session[:basket_id])
  rescue
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end
end
