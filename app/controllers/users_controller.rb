# encoding: UTF-8
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save_and_generate_token
      redirect_to new_user_path, notice: "Agora olha teu email lá! :)"
    else
      render :new
    end
  end
end
