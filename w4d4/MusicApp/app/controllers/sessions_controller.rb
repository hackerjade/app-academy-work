class SessionsController < ApplicationController
  def create
    email = session_params["email"]
    password = session_params["password"]
    @user = User.find_by_credentials(email, password)

    if @user
      flash[:success] = ["Welcome Back!"]
      redirect_to user_url  # redirect_to music app
    else
      flash.now[:errors] = ["email/password incorrect"]
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
