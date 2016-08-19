class UserMailer < ApplicationMailer
  default from: 'danebook@example.com'

  def welcome(user)
    mail to: user.email, subject: 'Welcome to Danebook'
  end

  # def activation(user)
  #   @user = user
  #   mail to: user.email, subject: 'Account Activation'
  # end

  # def password_reset(user)
  #   @user = user
  #   mail to: user.email, subject: 'Password Reset'
  # end
end
