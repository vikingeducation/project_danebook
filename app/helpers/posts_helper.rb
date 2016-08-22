module PostsHelper

  def delete_post_link(post)
    if current_user.id == post.author.id
      link_to "Delete Post", post_path(post), method: :delete, class: "delete_link"
    end
  end


end
