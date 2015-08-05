module PostsHelper
  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def display_like_or_unlike_button(likable)
    if current_user.likes? (likable)
      link_to "Unlike", likes_path(user_id: current_user.id, likable_id: likable.id, likable_type: likable.class), method: 'delete'
    else
      link_to "Like", likes_path(likable_id: likable.id, likable_type: likable.class), method: 'post'
    end
  end

  def present_likes_count(likable)
    if current_user && current_user.likes?(likable)
      return "You and #{pluralize(likable.likes.count - 1, 'other person like', 'other people like')} this!"
    else
      return "#{likable.likes.count} people like this!"
    end
  end
end
