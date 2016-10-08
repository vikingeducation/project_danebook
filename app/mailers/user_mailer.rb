class UserMailer < ApplicationMailer
  default from: "doctor@who.it"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the app!')
  end
end
