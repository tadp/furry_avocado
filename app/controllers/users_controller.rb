class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def new
    if signed_in?
      redirect_to user_url(current_user)
    else
      @user = User.new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password)
  end
end