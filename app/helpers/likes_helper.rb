module LikesHelper
  def liked?(likable)
    !!likable.likes.find_by(user_id: current_user.id)
  end

  def find_like(likable)
    likable.likes.find_by(user_id: current_user.id)
  end

  def post_like_text(post)
    remaining = post.likes.count
    current_text = ""
    current_likes = false
    user = ""
    extras = ""

    if liked?(post)
      current =  "You"
      extras = " like this."
      current_likes = true
      remaining -= 1
    else
      current = ""
    end

    if remaining > 0
      user = post.likes.where.not(user_id: current_user.id).first.user.first_name
      user = " and " + user if current_likes
      remaining -= 1
      extras = current_likes ? " like this." : "likes this."
    end

    if remaining > 0
      extras = " and #{remaining} others like this."
    end

    current + user + extras
  end
end
