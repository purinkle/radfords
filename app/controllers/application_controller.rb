class ApplicationController < ActionController::Base
  before_filter :ensure_domain

  protect_from_forgery
  
  include SessionsHelper

  APP_DOMAIN = 'radfordsofsomerford.co.uk'

  def ensure_domain
    return unless Rails.env.production?

    if request.env['HTTP_HOST'] != APP_DOMAIN
      redirect_to "http://#{APP_DOMAIN}", status: 301
    end
  end
end
