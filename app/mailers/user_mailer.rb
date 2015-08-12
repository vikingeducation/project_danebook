class UserMailer < ApplicationMailer
  default from: "danebook@shadefinale.com"
  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def comment_notification(to, from)
    @to = to
    @from = from
    mail(to: @to.email, subject: "#{@from.full_name} has commented on your Photo!")
  end
end
