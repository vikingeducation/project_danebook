module LikesHelper

  # generates the html for smart "Like" statistics
  def display_like_stats(post)
    post_likes = post.likes
    size = post_likes.size
    if signed_in_user?
      liked = post_likes.any? { |l| l.user_id == current_user.id } ? true : false
    else
      liked = false
    end
    result = ""
    result += "You and " if liked

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

    result += " likes this."
    return result
  end

end
