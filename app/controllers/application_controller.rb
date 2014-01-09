class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    deny_access unless signed_in?
  end

  private

  def current_basket
    Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end
end
