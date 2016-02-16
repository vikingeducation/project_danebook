module CommentsHelper

  # returns true if the current user has liked the comment
  def liked_comment?(comment)
    return false unless signed_in_user?
    if comment.likes.any? { |l| l.user_id == current_user.id }
      return true
    else
      return false
    end
  end

  # gets the liked comment
  def get_like(comment)
    like = comment.likes.select { |l| l.user_id == current_user.id }
    return like
  end

  # generates the html for smart "Like" statistics
  def display_like_stats(comment)
    comment_likes = comment.likes
    size = comment_likes.size
    if signed_in_user?
      liked = comment_likes.any? { |l| l.user_id == current_user.id } ? true : false
    else
      liked = false
    end

    result = ""
    if liked
      result += size > 1 ? "You and " : "You "
    else

    end

    remaining = liked ? size - 3: size - 2

    comment_likes = comment_likes.select { |l| l.user_id != current_user.id } if signed_in_user?

    comment_likes.each_with_index do |like, index|
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
