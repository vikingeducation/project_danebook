class UserMailer < ActionMailer::Base
  default from: "info@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def notify_comment(user, commentable)
    @user = user
    @commentable = commentable
    @class_name = commentable.class.to_s.downcase

    mail(to: @user.email, subject: 'Someone commented on your #{@class_name}')
  end
end
