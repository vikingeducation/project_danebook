class UserMailer < ApplicationMailer
  default from: 'no-reply@peaceful-fjord-47199.herokuapp.com'

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Spacebook!')
  end

  def comment_alert(comment)
    # commentable = comment.commentable
    # type = commentable.class.to_s.downcase
    # @commentable_url = send("#{type}_url".to_sym, commentable.id)
    @user = comment.commentable.user
    @comment = comment
    mail(to: @user.email, subject: 'Someone commented on your post')
  end
end
