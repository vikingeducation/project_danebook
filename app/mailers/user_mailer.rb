class UserMailer < ApplicationMailer
default from: "welcomecommittee@danebook.com"


  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def comment_alert(user)
    @user = user
    mail(to: @user.email, subject: "You've got a comment")
  end

end
