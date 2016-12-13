module CommentsHelper

  def display_comment_delete(user, post, comment)
    str = ""
    if current_user == comment.author
      str += link_to 'Delete', user_post_comment_path(user, post, comment), method: :delete
    end
    str.html_safe
  end

end
