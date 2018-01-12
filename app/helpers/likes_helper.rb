module LikesHelper

  def list_likes(likes)
    raw(likes.limit(3).map do |like|
      link_to like.user.name, user_timeline_path(like.user)
    end.join(", "))
  end

end
