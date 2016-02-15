module PostsHelper
  def liked_post?(post)
    return false unless signed_in_user?
    if post.likes.any? { |l| l.user_id == current_user.id }
      return true
    else
      return false
    end
  end

  def get_like(post)
    like = post.likes.select { |l| l.user_id == current_user.id }
    return like
  end
end
