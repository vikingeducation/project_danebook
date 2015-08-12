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

  # def show_like_count(object)
  #   like_count = Like.where(:likeable_id => object.id).count
  #   likers = Like.select(:user_id).where(:likeable_id => object.id)
  #   if like_count == 0
  #     return "Be the first to like this #{object.class}"
  #   elsif like_count == 1
  #     if current_user_like?(likers)
  #       str = "You"
  #     else
  #       str = "#{User.find(likers.first.user_id).full_name}"
  #     end
  #   elsif like_count > 1 && like_count < 4
  #     str = up_to_4_likers(likers)
  #   else
  #     str = up_to_4_likers(likers) + " and #{like_count} others"
  #   end
  #   str += " liked this #{object.class}"
  # end

  def show_like_count(object)
    current_user_like_or_other(object)
  end

  def current_user_like_or_other(object)
    likers = Like.select(:user_id).where(:likeable_id => object.id)
    if likers.include?(current_user.id)
      show_like_count_current_user(object, likers)
    else
      show_like_count_no_current_user(object, likers)
    end
  end

  def show_like_count_current_user(object, likers)
    str = ""
    like_count = likers.count
    if like_count == 0
      return "Be the First to Like This #{object.class}"
    elsif like_count == 1
      return "You liked this #{object.class}"
    elsif like_count > 1 && like_count < 4
      return up_to_4_likers(likers, true) + " liked this #{object.class}"
    else
      return up_to_4_likers(likers, true) + " and #{like_count - 3} 1 others liked this #{object.class}"
    end
  end

  def show_like_count_no_current_user(object, likers)
    str = ""
    like_count = likers.count
    if like_count == 0
      return "Be the First to Like This #{object.class}"
    elsif like_count == 1
      return "#{User.find(likers[0].user_id).full_name} liked this #{object.class}"
    elsif like_count > 1 && like_count < 4
      return up_to_4_likers(likers) + " liked this #{object.class}"
    else
      return up_to_4_likers(likers) + " and #{like_count - 3} others liked this #{object.class}"
    end
  end


  def up_to_4_likers(likers, c_user = false)
    str = ""
    if c_user
      str = "You"
      likers.each do |liker|
        binding.pry
        str += ", #{User.find(liker.user_id).full_name}" unless liker.user_id == current_user.id
      end
    else
      likers.each_with_index do |liker, i|
        if i == 0
          str += "#{User.find(liker.user_id).full_name}"
        elsif i > 3
          break
        else
          str += ", #{User.find(liker.user_id).full_name}"
        end
      end
    end
    str
  end

end
