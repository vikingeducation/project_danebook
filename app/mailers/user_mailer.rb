class UserMailer < ApplicationMailer
  default from: "valhalla@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def activity(user, comment)
    @user = user
    @comment = comment
    mail(to: @user.email, subject: 'Someone wrote a comment!')
  end
end
