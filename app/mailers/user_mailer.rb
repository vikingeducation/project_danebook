class UserMailer < ApplicationMailer
  default from: 'dane@book.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome!')
  end

  def new_comment(user)
    @user = user
    mail(to: @user.email, subject: 'New Comment!')
  end
end
