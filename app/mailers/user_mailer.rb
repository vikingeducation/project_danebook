class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def notify(receiver, commenter, resource)
    @user = receiver
    @commenter = commenter
    @resource = resource
    mail(to: @user.email, subject: 'New notification')
  end

end
