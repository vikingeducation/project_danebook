class UserMailer < ApplicationMailer
  default :from => "support@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

  def comment(owner_user, comment_user, comment)
    @comment = comment.body
    @owner_user = owner_user
    @comment_user = comment_user
    mail(to: @owner_user.email, subject: "Someone commented on your post!")
  end
end
