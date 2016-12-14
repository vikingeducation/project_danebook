module PostsHelper

  def post_liked_by_current_user(post, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & post.like_ids
      intersection.empty? ? false : true
    end
  end
end
