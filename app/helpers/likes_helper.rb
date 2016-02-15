module LikesHelper

  # generates the html for smart "Like" statistics
  def display_like_stats(post)
    post_likes = post.likes
    size = post_likes.size
    liked = post_likes.any? { |l| l.user_id == current_user.id } ? true : false
    result = ""
    if liked
      result += "You and "
      post_likes = post_likes.select { |l| l.user_id != current_user.id }
    end
    puts result
    if size < 3
      post_likes.each_with_index do |l, index|
        user = User.find(l.user_id)
        if index == size - 1
          result += link_to(user.name, user_path(user))
        else
          result += link_to(user.name, user_path(user)) + " and "
        end
      end
    else
      remaining = liked ? sized - 3 : size - 2
      result += "and #{remaining} others"
    end
      result += " likes this."
      return result
  end

end
