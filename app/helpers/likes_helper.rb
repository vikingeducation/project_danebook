module LikesHelper

  def like_or_unlike(likable)
    if likable.likes.find_by_user_id(current_user.id)
      link_to 'Unlike'
    else
      link_to 'Like ', likes_path(
          like: { likable_type: likable.class, likable_id: likable.id } ), 
          method: "POST"
    end
  end

  def like_count(likable)
    sentence = ""
    case likable.likes.size
    when 0
      return nil
    when 1
      sentence << "#{find_user_name(likable.likes.first.user_id)} liked this"
    when 2
      sentence << "#{find_user_name(likable.likes.first.user_id)} and #{find_user_name(likable.likes.second.user_id)} liked this"
    else
      sentence << "#{find_user_name(likable.likes.first.user_id)}, #{find_user_name(likable.likes.second.user_id)}, and #{likable.likes.size - 2} liked this"
    end
    sentence
  end

end
