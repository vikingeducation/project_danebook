module CommentsHelper

  def delete_comment_link(comment, commentable)
    if current_user == comment.author
      link_to "Delete Comment", comment_path(comment, commentable_id: commentable.id, commentable_type: commentable.class.to_s, user_id: comment.author.id), class: "delete_link pull-right", method: :delete, remote: true
    end
  end

end
