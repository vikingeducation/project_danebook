module PostsHelper
  def posts_delete_button(post)
    link_to "Delete", post_path(post),
                      method: :delete,
                      class: "col-xs-1 col-xs-offset-6",
                      data: {confirm: "Are you sure you want to delete this post?"} if current_user == @user
  end

end
