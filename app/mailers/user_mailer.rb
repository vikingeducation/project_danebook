class UserMailer < ApplicationMailer
  default :from => "from@example.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end
  handle_asynchronously :send_notification_email

  def notification(user)
    @user = user
    mail(to: @user.email, subject: 'You received a comment!')
  end
  handle_asynchronously :notification
end
