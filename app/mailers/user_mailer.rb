class UserMailer < ApplicationMailer
  default :from => "david@danebook.com"

  def welcome(user)
    @user=user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def comment(user, commentor, type)
    @user = user
    @commentor = commentor
    @type = "#{type.downcase}s"
    mail(to: @user.email, subject: "You have a new comment!")
  end
end
