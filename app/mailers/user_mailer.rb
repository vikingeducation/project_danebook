class UserMailer < ApplicationMailer

  def welcome(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

  def notify_comment(user_id, comment_id)
    @user = User.find(user_id)
    @comment = Comment.find(comment_id)
    mail(to: @user.email, subject: "You have a new comment on Danebook!")
  end

  def suggest_friends(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Make some new friends in Danebook!")
  end

end
