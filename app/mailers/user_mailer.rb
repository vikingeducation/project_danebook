class UserMailer < ApplicationMailer
  default from: 'this.guy@book.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the last book you\'ll ever need')
  end
end
