module CommentsHelper
  
  def comment_poster?(comment)
    current_user.id == comment.author.id
  end

end
