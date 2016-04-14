class CommentMailer < ApplicationMailer
  default from: "notifications@danebook.com"


  # comment is made on photo or post
  # owner of photo or post needs to be notified
  def new_comment(comment)
    @comment = comment
    type = @comment.commentable_type.classify
    @commented = type.constantize.find(@comment.commentable_id)
    @recipient = commented.first.user

    mail(to: @recipient.email, subject: "You have a new comment")
  end

end

