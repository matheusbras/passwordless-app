# encoding: UTF-8
class Notification < ActionMailer::Base
  default from: "estagiario@passwordlessapp.com"
  layout "mailer"

  def auth_link(user)
    @user = user

    mail to: @user.email, subject: "[Passwordless App] Aqui está seu link de acesso"
  end
end
