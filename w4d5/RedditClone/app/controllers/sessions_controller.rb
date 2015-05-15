class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = "Invalid username or password."
      redirect_to new_session_url
    end
  end

  def destroy
    @user = current_user
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def session_params
    params.require(:user).permit(:username,:password)
  end
end
