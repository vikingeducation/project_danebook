class UserMailer < ApplicationMailer

  default from: "welcome@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

  def comment_notification(comment)
    @comment = comment
    @parent_post = comment.commentable_type.constantize.find(comment.commentable_id)
    @commenting_user = User.find(comment.user_id)
    @user = User.find(comment.commentable_type.constantize.find(comment.commentable_id).user.id)
    mail(to: @user.email, subject: "You have a new Comment!")
  end


end
