# encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  ensure_security_headers # See more: https://github.com/twitter/secureheaders
  helper_method :current_user, :user_signed_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      nil
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate!
    user_signed_in? || redirect_to(root_url, notice: "Você precisa estar autenticado...")
  end
end
