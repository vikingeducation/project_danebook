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

    case scale
    when 0
      string = false
    when 1
      string = "#{object.likes[0].liker.name} likes this."
    when 2
      string = "#{object.likes[0].liker.name} and #{object.likes[1].liker.name} like this."
    else
      string = "#{object.likes[0].liker.name}, #{object.likes[1].liker.name}, and #{pluralize(scale - 2, 'other person')} like this."
    end

    string ? content_tag(:div, string, :class => 'col-xs-12 like-count') : nil
  end
end
