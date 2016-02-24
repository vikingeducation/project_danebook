class UserMailer < ApplicationMailer

  default from: "admin@danebook.com"

  def welcome(user)
    @user = user
    @profile = @user.profile

    mail(to: @user.email , subject: "Welcome to Danebook #{@profile.first_name}!")

  end

  def comment_notification(comment_id)
    @comment = Comment.find(comment_id)
    @user = @comment.user
    @to_user = @comment.commentable.user 

    mail(to: @to_user.email , subject: "Comment Notification by #{@user.username}")
    
  end
end
