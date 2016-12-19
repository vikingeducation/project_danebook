class UserMailer < ApplicationMailer

  default from: "TheDanebookProject@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook #{user.first_name}!")
  end
end
