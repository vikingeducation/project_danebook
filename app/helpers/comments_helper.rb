module CommentsHelper
  
  def comment_poster?(comment)
    if current_user && current_user.id == comment.author.id
      return true
    end
  end

end
