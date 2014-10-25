module LikesHelper
  def like_button(object)
    if user_like = object.likes.find_by_liker_id(current_user.id)
      link_to "Unlike", [object, user_like], method: "DELETE"
    else
      link_to "Like", [object, :likes], method: "POST"
    end
  end

  def likes_count(object)
    scale = object.likes.size
    string = false if scale == 0
    string = "#{object.likes[0].liker.name} " if scale > 0
    string += "#{object.likes[1].liker.name} " if scale > 1
    string += "#{pluralize(object.likes_count, 'other person')} " if scale > 2
    like = (scale > 1 ? "like" : "likes")

    string ? "<div class='col-xs-12'><p class='pull-left'>#{string + like + ' this.'}</p></div>".html_safe : nil
  end
end
