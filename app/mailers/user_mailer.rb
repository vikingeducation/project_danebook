class UserMailer < ActionMailer::Base
  default from: "admin@danishbook.herokuapp.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end
end
