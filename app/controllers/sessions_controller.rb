class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(session_params[:email], session_params[:password])

    if @user
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    sign_out!(current_user)
    redirect_to new_session_url
  end

  def new
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end