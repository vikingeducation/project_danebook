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
    last_user = likes.recent_user_like
    str += "<%= link_to last_user.full_name, user_path(last_user) %>"
    count = likes.count
    if count = 1
      str += " likes this."
    else
      str += "and #{count-1} others like this."
    end
  end

end
