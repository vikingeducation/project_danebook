module CommentsHelper

  def comment_owner_link_option(comment)
    if current_user == comment.user
      link_to "Delete", comment_path(comment), method: :delete, class: "col-md-2 pull-right", data: { confirm: "Are you sure?" }, :remote => true
    end
  end

end
