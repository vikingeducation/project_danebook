module TimelineHelper

  def likes_list(likes)
    raw(likes.limit(3).map do |like|
      link_to like.user.name, like.user
    end.join(", "))
  end

end
