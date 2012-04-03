class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery

  private

  def current_basket
    Basket.find(session[:basket_id])
  rescue
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end
end
