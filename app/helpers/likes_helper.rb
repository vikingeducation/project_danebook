module LikesHelper

  def display_like_button(user, likeable)
    str = ""
    if likeable.likers.include?(current_user)
      str += link_to 'Unlike', like_path(id: user.id, likeable_type: likeable.class.name, likeable_id: likeable.id), method: :delete
    else
      str += link_to 'Like', likes_path(id: user.id, likeable_type: likeable.class.name, likeable_id: likeable.id), method: :post
    end
    str.html_safe
  end

  def display_likers(user, likeable)

    str = ""

    if likeable.likes.any?
      str += "#{pluralize(likeable.total_likes, 'person')} liked this including #{likeable.random_liker}"
    end

    str.html_safe

  end

end
