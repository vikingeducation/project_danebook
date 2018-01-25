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

    def display_like_unlike(object)
      klass = object.class.to_s

      if current_user.send("#{klass.downcase.pluralize}_they_like").include?(object)
        like = Like.current_user_like(object, current_user)
        link_to 'Unlike', polymorphic_url([current_user, object, like], likeable: klass), method: :delete
      else
        link_to 'Like', polymorphic_url([current_user, object, :likes], likeable: klass), method: :post
      end
    end

end
