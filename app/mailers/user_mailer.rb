class UserMailer < ApplicationMailer
  default from: 'danebook@example.com'

  def welcome(user)
    mail to: user.email, subject: 'Welcome to Danebook'
  end

  def notify_like(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
  end

  def notify_comment(user,resource)
    @user = user
    @resource = resource
    mail to: user.email, subject: 'Activity on your Timeline'
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
