class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :authenticate, :find_basket

  def authenticate
    deny_access unless signed_in?
  end

  def find_basket
    @basket = BasketDecorator.new(FindBasket.call(id: session["basket_id"]))
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
