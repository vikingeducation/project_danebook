module CommentsHelper

  def delete_comment_button(comment)
    link_to "Delete",
            comment_path(id: comment.id),
            method: :delete,
            class: "col-xs-2",
            remote: true,
            data: {confirm: "Are you sure you want to delete this comment?"} if comment.author == current_user
  end
end
