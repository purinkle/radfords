class SessionsController < ApplicationController
  skip_before_action :authenticate

  def new
    @title = "Sign In"
  end

  def create
    credentials = params.require(:session)
    user = User.authenticate(credentials[:email], credentials[:password])

    if user
      sign_in user
      redirect_back_or events_path
    else
      sign_in_failed
    end
  end

  def destroy
    sign_out

    redirect_to root_path, flash: { success: t(".success") }
  end

  private

  def sign_in_failed
    flash.now[:alert] = t("sessions.create.alert")
    @title = "Sign In"
    render "new"
  end
end
