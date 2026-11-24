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

  # Saves a new record and shows it, or shows its form again with the errors.
  def create_and_show(record)
    record.save!
    redirect_to(record, notice: t(".notice"))
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  def current_basket
    Basket.with_line_items.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    basket = Basket.create
    session[:basket_id] = basket.id
    basket
  end
end
