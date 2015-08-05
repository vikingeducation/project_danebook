module LikesHelper

  def like_display(obj)
    likes = obj.likes
    count = likes.size
    str =""
    if count <= 0
      str += link_to "Be the first to like this", like_path(post), method: post
    elsif likes.you_liked?(current_user) && count == 1
      str += "You like this."
    elsif count > 1
      num = 1
      if likes.you_liked?(current_user)
        str += "You"
        count == 2 ? str += " and " : str += ", "
        num += 1
      end

      user = name_of_other_liker(likes)

      str += link_to user.full_name, user_path(user.id)
      num_ppl = pluralize( (count-num), 'other' )
      count > 2 ? str += ", and #{num_ppl} like this." : str += "and #{num_ppl} likes this"

    end
    str.html_safe
  end

  def name_of_other_liker(likes)
    likes.first.user == current_user ? likes.second.user : likes.first.user
  end


  def like_or_unlike_link(object)
    if object.likes.you_liked?(current_user)
      str = link_to "Unlike", unlike_path(like: {:likings_id => object.id, :likings_type => object.class.to_s}), method: :delete, class: "col-xs-2"
    else
      str = link_to "Like", like_path(like: {:likings_id => object.id, :likings_type => object.class.to_s}), method: :post, class: "col-xs-12"
    end
  end

  # def like_name_list(likes)
  #   str = ""
  #   num = 1
  #   if likes.you_liked?(current_user)
  #     str += "You and "
  #     num+=1
  #   end

  #   last_user = likes.recent_user_like
  #   str += last_user.full_name
  #   count = likes.count
  #   if count = 1
  #     str += " likes this."
  #   else
  #     str += "and #{pluralize(count-num, "other")} like this."
  #   end
  # end
end
