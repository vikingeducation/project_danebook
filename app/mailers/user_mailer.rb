class UserMailer < ApplicationMailer

  default :from => "admin@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome!")
  end

end
