class UserMailer < ApplicationMailer

  def welcome_email(user)
    @greeting = "Hi"

    mail to: user.email, subject: "Welcome"
  end

  def forgot_password_email(user)
    @user = user
    @url = DOMAIN+"/reset_password?id=#{user.id}&token=#{user.reset_password_token}"

    mail to: user.email, subject: "Forgot password"
  end

  def password_change_email(user)
    @user = user

    mail to: user.email
  end

  def email_change_confirmation_email(user)
    @user = user
    @confirm_email_change_url=DOMAIN+"/confirm_email_change?id=#{user.id}&token=#{user.email_change_token}"

    mail to: user.change_email, subject: "Email change confirmation"
  end
end
