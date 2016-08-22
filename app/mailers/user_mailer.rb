class UserMailer < ApplicationMailer
  default from: 'leo@book.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the last book you\'ll ever need')
  end
end
