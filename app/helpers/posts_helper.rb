module PostsHelper
  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def display_like_or_unlike_button(post)
    if @user.likes? (post)
      link_to "Unlike", likes_path(user_id: @user.id, likable_id: post.id, likable_type: 'post'), method: 'delete'
    else
      link_to "Like", likes_path(likable_id: post.id, likable_type: 'post'), method: 'post'
    end
  end
end
