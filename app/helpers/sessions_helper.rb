module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = user.remember_token
    Current.user = user
  end

  # The user whose remember token this request carries, if any.
  def current_user
    token = cookies.signed[:remember_token]
    Current.user ||= User.authenticate_with_salt(*token) if token
  end

  def signed_in?
    current_user.present?
  end

  def sign_out
    cookies.delete(:remember_token)
    Current.user = nil
  end

  def deny_access
    session[:return_to] = request.fullpath
    redirect_to(signin_path, alert: t("sessions.unauthenticated"))
  end

  def redirect_back_or(default)
    redirect_to(session.delete(:return_to) || default)
  end
end
