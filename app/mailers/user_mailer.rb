class UserMailer < ApplicationMailer

  default from: 'no-reply@danebook.com'

  def welcome(user)
    @user = user
    @friends = User.recommended_friends(@user)
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def comment_notification(comment)
    @comment = comment
    @commenter = @comment.user
    @recipient = @comment.commentable.user
    mail(to: @recipient.email, subject: "New Comment from #{@commenter.full_name}")
  end

end
