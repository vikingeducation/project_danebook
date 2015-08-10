module LikesHelper

  #need to refactor this super long method
  def like_display(obj)
    likes = obj.likes
    count = likes.size
    if count <= 0
      str = link_to "Be the first to like this.", like_path(post), method: post

    elsif likes.you_liked?(current_user) && count == 1
      str = "You like this."

    elsif count == 1 && !likes.you_liked?(current_user)
      user = name_of_other_liker(likes)
      str = link_to user.full_name, user_path(user.id)
      str += " likes this."

    elsif count > 1
      str = ""
      num = 1
      if likes.you_liked?(current_user)
        str = "You"
        count == 2 ? str += " and " : str += ", "
        num += 1
      end

      user = name_of_other_liker(likes)
      str += link_to user.full_name, user_path(user.id)

      num_ppl = pluralize( (count-num), 'other' )

      if count >= 2 && (count-num) > 0
        str += ", and #{num_ppl} like this."
      else
        str += " like this."
      end
    end
    str.html_safe
  end


  def name_of_other_liker(likes)

    likes.first.user == current_user ? likes.second.user : likes.first.user

  end


  def like_or_unlike_link(object)
    if object.likes.you_liked?(current_user)
      link_to "Unlike", unlike_path(like: {:likings_id => object.id, :likings_type => object.class}), method: :delete, class: "col-xs-2"
    else
      link_to "Like", like_path(like: {:likings_id => object.id, :likings_type => object.class}), method: :post, class: "col-xs-12"
    end
  end

end
