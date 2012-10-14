class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    deny_access unless signed_in?
  end
end
