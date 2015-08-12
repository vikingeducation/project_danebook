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
  
end
