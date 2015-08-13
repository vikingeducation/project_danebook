module ApplicationHelper

  def like_button(likable)
    if likable.liked_by?(current_user)
      str = link_to("Unlike", 
                    like_path(likable.get_id_of_the_like_by(current_user)), 
                    method: :delete, 
                    style: "color:red;")
    else
      str = link_to("Like", 
                    likes_path(user_id: current_user.id,
                               likable_id: likable.id,
                               likable_type: likable.class.to_s), 
                    method: :post)
    end
    str.html_safe
  end

  def friending_button(friend)
    if current_user == friend
      str = ""
    elsif current_user.has_friended?(friend)
      str = link_to("Unfriend Me", 
                    friending_path(id: friend.id),
                    method: :delete, 
                    class: "btn btn-danger")
    else
      str = link_to("Friend Me", 
                    friendings_path(id: friend.id),
                    method: :post, 
                    class: "btn btn-primary")
    end
    str.html_safe
  end

  def cover_image(user)
    if user.cover_photo
      image_tag(user.cover_photo.user_photo.url, 
                class: "cover-pic hidden-sm hidden-xs")
    else
      image_tag(image_path("icon_photo_small.png"), 
                class: "cover-pic hidden-sm hidden-xs")
    end
  end

  def profile_image(user)
    if user.profile_photo
      image_tag(user.profile_photo.user_photo.url, 
                class: "hidden-sm hidden-xs profile-pic")
    else
      image_tag(image_path("user_silhouette_generic.gif"), 
                class: "hidden-sm hidden-xs profile-pic")
    end
  end

  def display_likes_msg(likable)
    return nil if likable.likes.empty?
    creator_name(likable.likes) + like_msg_base(likable.likes)      
  end

  def creator_name(like_list)
    str = like_list.limit(3).includes(:profile).inject("") do |str, like|
      str + "#{like.user.profile.full_name} and "
    end
    str[0..-5]
  end

  def like_msg_base(like_list)
    num = like_list.count
    if num == 1
      "likes this."
    elsif num <= 3
      "like this."
    else
      "and #{num - 3} " + "other".pluralize(num-3) + " like this."
    end

  end
end
