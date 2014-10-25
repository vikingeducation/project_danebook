module LikesHelper
  def like_button(object)
    if object.likes.find_by_user_id(current_user.id)
      link_to "Unlike", [object, object.likes.find_by_user_id(current_user.id)], method: "DELETE"
    else
      link_to "Like", [object, :likes], method: "POST"
    end
  end
end
