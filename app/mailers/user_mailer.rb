class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(
      :to => @user.email,
      :subject => subject("Welcome to Danebook #{@user.name}!")
    )
  end
end
