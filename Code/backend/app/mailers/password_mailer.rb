class PasswordMailer < ApplicationMailer
  default from: ENV['DEFAULT_EMAIL_FROM']

  def reset_password_instructions(user)
    @user = user
    @url = password_url(token: user.reset_password_token)
    mail(to: @user.email, subject: 'Reset password request')
  end
end
