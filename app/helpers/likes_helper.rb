module LikesHelper
  def like_button(object, parent=nil)
    if user_like = object.likes.find_by_liker_id(current_user.id)
      link_to "Unlike", [parent, object, user_like], method: "DELETE"
    else
      link_to "Like", [parent, object, :likes], method: "POST"
    end
  end

  def likes_count(object)
    scale = object.likes.size

    if scale > 2
      string = "#{object.likes[0].liker.name}, #{object.likes[1].liker.name}, and #{pluralize(scale - 2, 'other person')} like this."
    elsif scale == 2
      string = "#{object.likes[0].liker.name} and #{object.likes[1].liker.name} like this."
    elsif scale == 1
      string = "#{object.likes[0].liker.name} likes this."
    else
      string = false
    end

    string ? content_tag(:div, content_tag(:p, string, :class => 'pull-left'), :class => 'col-xs-12') : nil
  end
end
