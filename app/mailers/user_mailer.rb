class UserMailer < ApplicationMailer
  default :from => "no_reply@ajk-danebook.herokuapp.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Danebook!")
  end

  def notify(comment)
    @user = comment.commentable.author
    @commenter_name = comment.author.profile.full_name
    @commentable_type = comment.commentable_type.downcase
    mail(to: @user.email, subject: "#{@commenter_name} commented on your #{@commentable_type}!")
  end

end
