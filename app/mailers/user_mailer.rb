class UserMailer < ApplicationMailer
  default :from => "darbis@gmail.com"

  def welcome(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Danebook!")
  end

  def new_comment_msg(user)
    @user = user
    mail(:to => @user.email, :subject => "You have got new comments today!")
  end


end
