module CommentsHelper
  def comment_liked_by_current_user(comment_likes, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & comment_likes.pluck(:id)
      intersection.empty? ? false : true
    end
  end
end
