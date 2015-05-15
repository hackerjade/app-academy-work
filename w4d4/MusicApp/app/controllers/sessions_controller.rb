class SessionsController < ApplicationController
  def create
    email = session_params["email"]
    password = session_params["password"]
    @user = User.find_by_credentials(email, password)

    if @user
      flash[:success] = ["Welcome Back!"]
      log_in_user!(@user)
      redirect_to user_url
    else
      @user = User.new(session_params)
      flash.now[:errors] = ["email/password incorrect"]
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
