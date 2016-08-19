class UserMailer < ApplicationMailer
  default from: "matthew.hinea@gmail.com"

  def welcome(user)
    @user = user   
    mail(to: @user.email, subject: "Welcome to Hinea Co.!")  
  end
end
