module CommentsHelper
  def comment_anchor(comment)
    anchor_id = comment_anchor_id_for(comment)
    %Q[<a href="##{anchor_id}"></a>].html_safe
  end

  def comment_anchor_id_for(comment)
    "user-#{comment.user.id}-comment-#{comment.id}"
  end
end
