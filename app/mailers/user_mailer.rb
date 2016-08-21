class UserMailer < ApplicationMailer
  default from: 'no-reply@peaceful-fjord-47199.herokuapp.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Spacebook!')
  end

  def comment_alert(comment)
    @user = comment.commentable.user
    commentable = comment.commentable
    type = commentable.class.to_s.downcase
    @commentable_url = send("#{type}_url".to_sym, commentable.id)
    mail(to: @user.email, subject: 'Someone commented on your post')
  end
end
