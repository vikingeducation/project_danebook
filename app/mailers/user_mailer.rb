class UserMailer < ApplicationMailer
    default :from => "olga@danebook.com"

  def welcome(user)
    @user=user
    mail(to: @user.email, subject: 'Welcome to Olga\'s Danebook!')
  end
end
