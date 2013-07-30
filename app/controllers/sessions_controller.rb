class SessionsController < ApplicationController
  skip_before_filter :authenticate

  def new
    @title = 'Sign In'
  end

  def create
    user = User.authenticate( params[:session][:email],
      params[:session][:password] )

    if user.nil?
      flash[:alert] = "Invalid email or password."

      @title = 'Sign In'

      render 'new'
    else
      sign_in user

      redirect_back_or events_path
    end
  end

  def destroy
    sign_out

    redirect_to root_path, flash: {success: 'You successfully signed out.'}
  end
end
