class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  before_filter :authenticate

  private

  def authenticate
    deny_access unless signed_in?
  end
end
