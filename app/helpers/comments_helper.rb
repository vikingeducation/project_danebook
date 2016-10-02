module CommentsHelper
  def comment_liked_by_current_user(comment)
    if current_user
      intersection = current_user.initiated_like_ids & comment.like_ids
      intersection.empty? ? false : true
    end
  end
end
