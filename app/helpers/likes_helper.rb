module LikesHelper

  def get_like_text(likable, current_user)
    like_count = likable.likes.count
    return if like_count.zero?
    txt = ""
    if likable.liked_by_user?(current_user.id)
      like_count -= 1
      if like_count > 0
        txt += "You and "
      else
        txt += "You "
      end
    end
    if like_count > 0
      if likable.likes.first.user_id != current_user.id
        like = likable.likes.first
      else
        like = likable.likes.second
      end
      txt += "#{like.user.profile.full_name} "
      like_count -= 1
    end
    if like_count > 0
      txt += "and #{like_count} other "
      txt += like_count == 1 ? "person " : "people "
    end
    txt += (likable.liked_by_user?(current_user.id) ? "like " : "likes ")
    txt + "this."
  end

  def like_button(likable, user)
    like = likable.liked_by_user?(user.id)
    ### Likes and comments for photos have different routes...
    ### Gotta fix this eventually
    if likable.class.to_s == "Photo"
      if like
        link_to "Unlike", url_for([likable.user, likable, like]), method: :delete
      else
        link_to "Like", url_for([likable.user, likable, :likes]), method: :post
      end
    else
      if like
        link_to "Unlike", url_for([likable, like]), method: :delete
      else
        link_to "Like", url_for([likable, :likes]), method: :post
      end
    end
  end

end
