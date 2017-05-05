class UserMailer < ApplicationMailer
  require 'open-uri'

  default from: 'no-reply@danebook.com'

  def welcome(user)
    @user = user
    @friends = User.recommended_friends(@user)
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

end
