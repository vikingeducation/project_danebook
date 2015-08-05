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
      return "You#{friend_string(likable)} #{other_people_like_string(likable)}like this!"
    else
      return "#{pluralize(likable.likes.count, 'person likes', 'people like')} this!"
    end
  end

  def other_people_like_string(likable)
    "and #{pluralize(likable.likes.count - 1, 'other person ', 'other people ')} " if likable.likes.count > 1
  end

  def friend_string(likable)
    if current_user.friends.any?{|friend| friend.likes?(likable)}
      generate_friend_string(likable)
    else
      return ""
    end
  end

  def generate_friend_string(likable)
    return_string = ", "
    friends_that_like = current_user.friends.select{|friend| friend.likes?(likable)}
    friends_that_like.each do |friend|
      return_string += link_to friend.full_name, friend
      return_string += ", "
    end
    return return_string
  end
end
