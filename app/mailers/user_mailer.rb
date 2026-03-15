# Mailer for user-related emails
class UserMailer < ApplicationMailer
  default from: "Patryk <patryk@szkoleo.patrykrogala.dev>"

  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: I18n.t("user_mailer.welcome_email.subject"))
  end
end
