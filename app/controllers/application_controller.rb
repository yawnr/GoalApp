class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :signed_in?

  def login(user)
    session[:session_token] = user.reset_session_token
    redirect_to user_url(user)
  end

  def logout
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def current_user
    if session[:session_token]
      @current_user ||= User.find_by_session_token(session[:session_token])
    else
      nil
    end
  end

  def signed_in?
    !!current_user
  end

  def require_signed_in
    redirect_to new_session_url unless signed_in?
  end

end
