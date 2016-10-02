module PostsHelper

  def post_liked_by_current_user(post)
    if current_user
      intersection = current_user.initiated_like_ids & post.like_ids
      intersection.empty? ? false : true
    end
  end
end
