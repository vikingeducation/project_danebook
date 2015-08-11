class UserMailer < ApplicationMailer

  default from: "admin@danebook.com",
          to: "personal@email.com",
          subject: "Email from Danebook"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

end
