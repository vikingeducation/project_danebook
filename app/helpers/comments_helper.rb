module CommentsHelper

  def delete_comment_link(comment)
    if current_user == comment.user
      link_to 'Delete', comment_path(comment), method: :delete, data: { confirm: 'Are you sure?' }
    end
  end

end
