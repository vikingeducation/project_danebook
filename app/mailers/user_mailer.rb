class UserMailer < ApplicationMailer
  default from: "mrdane@danebook.com"

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Danebook!')
  end

  def notification(user, comment)
    @writer = User.find(comment.user_id)
    @user = user
    @comment = comment
    mail(to: @user.email, subject: 'A comment has been added.')
  end

end
