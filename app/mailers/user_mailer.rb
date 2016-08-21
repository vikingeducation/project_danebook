class UserMailer < ApplicationMailer
  default from: 'no-reply@peaceful-fjord-47199.herokuapp.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Spacebook!')
  end
end
