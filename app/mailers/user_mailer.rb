class UserMailer < ApplicationMailer
  default from: "support@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def comment(user)
    @user = user
    mail(to: @user.email, subject: 'Someone has Commented on your post/photo')
  end
end
