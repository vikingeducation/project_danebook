class CommentMailer < ApplicationMailer

  default from: "comments@danebook.com"

  def comment(user)
    @user = user
    mail(to: @user.email, subject: 'Someone commented on your post!')
  end

end
