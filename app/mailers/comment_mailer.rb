class CommentMailer < ApplicationMailer

  default from: "admin@danebook.com",
          to: "personal@email.com",
          subject: "Comment in Danebook"

  def notify(comment)
    @comment = comment
    parent = @comment.commentable
    case parent.class.to_s.downcase
    when "photo"
      @link = photo_url(parent)
      mail( to: parent.user.email,
            subject: "#{@comment.author.name} commented on your photo!")
    when "post"
      @link = user_timeline_url(parent.recipient_user.id)
      mail( to: parent.author.email,
            subject: "#{@comment.author.name} commented on your post!")
    else
      @link = user_timeline_url(parent.author.id)
      mail( to: parent.author.email,
            subject: "#{@comment.author.name} has commented on your #{parent.class.to_s.downcase}!")
    end
  end

end
