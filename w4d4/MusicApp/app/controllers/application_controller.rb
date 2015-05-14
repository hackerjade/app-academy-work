class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,
    :logged_in?,
    :log_in_user!,
    :log_out!,
    :log_in_filter

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def log_in_filter
    if !logged_in?
      flash[:errors] = ["You must be logged in to gain access"]
      redirect_to new_session_url
    end
  end

  def logged_in?
    current_user != nil
  end

  def log_in_user!(user)
    @current_user = user
    session[:session_token] = user.session_token
    user.save!
  end

  def log_out!
    session[:session_token] = nil
    current_user = nil
  end

end
