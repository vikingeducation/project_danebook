class UserMailer < ApplicationMailer
  default :from => "thebomb@dot.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook by Adrian!')
  end

  def trigger(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: 'Thanks for being active on Danebook!')
  end
end
