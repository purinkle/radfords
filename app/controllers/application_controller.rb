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

  # Saves a new record and shows it, or wherever else it belongs, or shows
  # its form again with the errors.
  def create_and_show(record, location = record)
    record.save!
    redirect_to(location, notice: t(".notice"))
  rescue ActiveRecord::RecordInvalid
    render "new"
  end

  # The same for a change to a record that already exists.
  def update_and_show(record, attributes, location = record)
    record.update!(attributes)
    redirect_to(location, notice: t(".notice"))
  rescue ActiveRecord::RecordInvalid
    render "edit"
  end

  # The basket in the session, or a new one put there.
  def current_basket
    Basket.with_line_items.find_by(id: session[:basket_id]) ||
      Basket.create.tap { |basket| session[:basket_id] = basket.id }
  end
end
