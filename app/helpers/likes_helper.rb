module LikesHelper

  # generates the html for smart "Like" statistics
  def display_like_stats(post)
    post_likes = post.likes
    size = post_likes.size
    return "" if size == 0
    if signed_in_user?
      liked = post_likes.any? { |l| l.user_id == current_user.id } ? true : false
    else
      liked = false
    end

    result = ""
    if liked
      result += size > 1 ? "You and " : "You "
    else

    end

    remaining = liked ? size - 3: size - 2

    post_likes = post_likes.select { |l| l.user_id != current_user.id } if signed_in_user?

    post_likes.each_with_index do |like, index|
      user = User.find(like.user_id)

      if index == 1 || index == size - 2
        result += link_to(user.name, user_path(user))
        break
      elsif index < 1
        result += link_to(user.name, user_path(user)) + " and "
      end
    end

    result += " and #{remaining} others" if remaining > 0

    if size > 3
      result += " likes this."
    elsif
        result += liked ? " like this." : " likes this."
    end
    return result
  end

end
