module LikesHelper

  def list_likes(likes)
    raw(likes.limit(3).map do |like|
      link_to like.user.name, user_timeline_path(like.user)
    end.join(", "))
  end

  def display_likes_count(object)
    object.likes.count
  end

  def display_users_who_liked(object)
    object.likes.map do |like|
      link_to like.user.name, like.user
    end
  end

end
