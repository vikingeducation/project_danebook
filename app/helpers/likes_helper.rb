module LikesHelper

  def show_like_or_unlike(object)
    like_object = Like.find_liked_object(object, current_user)
    if like_object
      show_unlike(like_object)
    else
      show_like(object)
    end
  end

  def show_unlike(like)
    link_to("Unlike", user_like_path(:id => like.id, :user_id => current_user.id), method: :delete)
  end

  def show_like(object)
    link_to("Like", user_likes_path(:user_id => current_user, :like => {:user_id => current_user.id,
                                              :likeable_id => object.id,
                                              :likeable_type => object.class,
                                              }), method: :post)
  end

  def show_like_count(object)
    like_count = Like.where(:likeable_id => object.id).count
    likers = Like.select(:user_id).where(:likeable_id => object.id)
    if like_count == 0
      return "Be the first to like this post"
    elsif like_count == 1
      str = "#{User.find(likers.first.user_id).full_name}"
    elsif like_count > 1 && like_count < 4
      str = up_to_4_likers(likers)
    else
      str = up_to_4_likers(likers) + " and #{like_count} others"
    end
    str += " liked this post"
  end

  def up_to_4_likers(likers)
    str = ""
    likers.each_with_index do |liker, i|
      if liker[i] == liker[-1]
        str += ", and #{User.find(liker.user_id).full_name}"
      elsif i == 1
        str += "#{User.find(liker.user_id).full_name}"
      else
        str += ", #{User.find(liker.user_id).full_name}"
      end
    end
    str
  end



end
