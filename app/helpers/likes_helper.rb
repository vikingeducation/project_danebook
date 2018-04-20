module LikesHelper

  def list_likes(likes)
    raw(likes.limit(3).map do |like|
      link_to like.user.name, user_timeline_path(like.user)
    end.join(", "))
  end

  def display_users_who_liked(object)
    object.likes.map do |like|
      link_to like.user.name, like.user
    end
  end

  def toggle_like_link(object)
    klass = object.class.to_s
    like = object.likes.to_a.find { |l| l.user_id == current_user.id }

    if like == nil
      link_to 'Like', polymorphic_url([current_user, object, :likes], likeable: klass), remote: true, method: :post
    else
      link_to 'Unlike', polymorphic_url([current_user, object, like], likeable: klass), remote: true, method: :delete
    end
  end

end
