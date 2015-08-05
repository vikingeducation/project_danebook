module LikesHelper

  def like_display(likes)
    if likes == 0
      "Like"
    elsif likes.you_liked?(current_user) && likes.count == 1
      "You like this."
    else
      like_name_list(likes)
    end
  end

  def like_name_list(likes)
    str = ""
    if likes.you_liked?(current_user)
      str += "You and "
    end
    str += likes.recent_user_like
    count = likes.count
    if count = 1
      str += " likes this."
    else
      str += "and #{count-1} others like this."
    end
  end

end
