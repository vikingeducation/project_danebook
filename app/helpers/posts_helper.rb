module PostsHelper
  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def display_like_or_unlike_button(likable)
    if @user.likes? (likable)
      link_to "Unlike", likes_path(user_id: @user.id, likable_id: likable.id, likable_type: likable.class), method: 'delete'
    else
      link_to "Like", likes_path(likable_id: likable.id, likable_type: likable.class), method: 'post'
    end
  end
end
