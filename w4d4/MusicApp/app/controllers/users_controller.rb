class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = ["Welcome to Music App!"]
      redirect_to # Music app page?
    else
      flash[:errors] = @users.errors.full_messages
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
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
