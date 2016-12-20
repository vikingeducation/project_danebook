class UserMailer < ApplicationMailer
  default from: "do_not_reply@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Salutations, new user!")
  end
end
