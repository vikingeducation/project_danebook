module CommentsHelper

  def comment_owner_link_option(comment)
    if current_user == comment.user
      link_to "Delete", comment_path(comment), method: :delete, class: "col-xs-1 col-xs-offset-6"
    end
  end

end
