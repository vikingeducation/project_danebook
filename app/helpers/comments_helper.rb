module CommentsHelper
  def comment_liked_by_current_user(comment, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & comment.like_ids
      intersection.empty? ? false : true
    end
  end
end
