class CommentMailer < ApplicationMailer
  default from: "TheDanebookProject@danebook.com"

  def commented_on(user)
    @user = user
    mail(to: @user.email, subject: "You have a comment!")
  end
end
