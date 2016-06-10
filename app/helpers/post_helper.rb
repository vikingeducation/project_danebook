module PostHelper
  def show_like_options(post)
    current_user && current_user.liked_post_ids.include?(post.id)
  end

  def proper_user(user)
    sign_in_user? && current_user == user
  end
end
