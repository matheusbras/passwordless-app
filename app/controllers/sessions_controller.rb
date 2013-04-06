# encoding: UTF-8
class SessionsController < ApplicationController
  def create
    user = User.find_by_access_token!(params[:token])
    session[:user_id] = user.id
    redirect_to(secret_page_path, notice: "Você está online! :)")
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_url, notice: "Acesso inválido... recupere sua senha.")
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Volte em breve!"
  end
end
