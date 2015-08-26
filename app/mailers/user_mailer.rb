class UserMailer < ApplicationMailer
  default :from => "no_reply@ajk-danebook.herokuapp.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

end
