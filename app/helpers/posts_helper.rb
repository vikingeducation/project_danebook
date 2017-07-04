module PostsHelper

  def delete_post_button(post, user)
    ### Display only if it's the author
    if post.user == user
      link_to "Delete", user_post_path(current_user, post), method: :delete, class: "pull-right"
    end
  end

end
