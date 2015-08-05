module ProfilesHelper
  def likes_counter(post)
    count = post.likes.count

    if count == 0
      str = link_to "Be the first to like this.", post_likes_path(post), method: :post
    elsif post.already_liked_by?(current_user) && count == 1
      str = "(You like this)."
    elsif post.already_liked_by?(current_user) && count == 2
      str = "(You and 1 other like this)."
    elsif post.already_liked_by?(current_user) && count > 1
      str = "(You and #{count-1} others like this)."
    else
      str = link_to("Like", post_likes_path(post), method: :post)
      str + other_likes(post)
    end
  end

  def other_likes(post)
    if post.likes.count == 1
      " (One other likes this)."
    else
      " (#{post.likes.count} others like this)."
    end
  end

  def like_str(post)
    if post.already_liked_by?(current_user)
      str = link_to("Unlike ", like_path(current_user_like(post)), method: :delete)
    else
      str = ''
    end
    (str + likes_counter(post)).html_safe
  end

  private

  def current_user_like(post)
    post.likes.where(:user_id => current_user.id).first
  end

end
