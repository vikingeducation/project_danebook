module LikesHelper
  def render_like(post)
    if post.liked_user_ids.include?(current_user.id)
      link_to "Unlike", like_path(post), method: :delete
    else
      link_to "Like", like_path(post), method: :put
    end
  end
end
