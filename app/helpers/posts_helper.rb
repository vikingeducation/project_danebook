module PostsHelper
  def post_anchor(post)
    anchor_id = post_anchor_id_for(post)
    %Q[<a href="##{anchor_id}"></a>].html_safe
  end

  def post_anchor_id_for(post)
    "user-#{post.user.id}-post-#{post.id}"
  end
end
