module LikesHelper
  def liked?(likable)
    !!likable.likes.find_by(user_id: current_user.id)
  end

  def find_like(likable)
    likable.likes.find_by(user_id: current_user.id)
  end

  def post_like_text(post)
    remaining = post.likes.count
    like = post.likes.where.not(user_id: current_user.id).first
    user = like.user if like
    current_text = ""
    current_likes = false
    user_text = ""
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
      user_text = "<a href='#{user_path(user)}'>#{user.name}</a>"
      user_text = " and " + user_text if current_likes
      remaining -= 1
      extras = current_likes ? " like this." : " likes this."
    end

    if remaining > 0
      extras = " and #{remaining} #{ remaining > 1 ? 'others' : 'other' } like this."
    end

    (current + user_text + extras).html_safe
  end

end
