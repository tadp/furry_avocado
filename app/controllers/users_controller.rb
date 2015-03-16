class UsersController < ApplicationController
  def create
    @user
  end

  def new
    @user = User.new
  end
end