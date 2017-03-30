module CommentsHelper

  def delete_comment_link(comment)
    if comment.user == current_user
      link_to "Delete Comment", comment, method: "delete", class: 'col-sm-1'
    end
  end

end
