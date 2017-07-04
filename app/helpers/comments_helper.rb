module CommentsHelper

  def delete_comment_button(comment, user)
    ### Display only if it's the author
    if comment.user == user
      link_to "Delete", url_for([comment.commentable, comment]), method: :delete, class: "pull-right"
    end
  end
end
