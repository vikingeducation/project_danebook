module PostsHelper

  def post_liked_by_current_user(post_likes, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & post_likes.pluck(:id)
      intersection.empty? ? false : true
    end
  end
end
