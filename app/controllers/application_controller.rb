class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :sign_in!, :sign_out!, :signed_in?, :ensure_current_user

  def current_user
    @user ||= User.find_by_session_token(session[:session_token])
  end

  def sign_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def sign_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def signed_in?
    !!current_user
  end

  def ensure_current_user
    unless signed_in?
      redirect_to new_session_url
    end
  end
end
