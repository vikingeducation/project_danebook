class CommentMailer < ApplicationMailer

  default from: "comments@danebook.com"

  def comment(user, other_user)
    @user = user
    @other_user = other_user
    mail(to: @user.email, subject: 'Someone commented on your post!')
  end

end
