module ApplicationHelper

  def like_button(likable)
    if likable.liked_by?(current_user)
      str = link_to("Unlike", 
                    like_path(likable.get_id_of_the_like_by(current_user)), 
                    method: :delete)
    else
      str = link_to("Like", 
                    likes_path(user_id: current_user.id,
                               likable_id: likable.id,
                               likable_type: likable.class.to_s), 
                    method: :post)
    end
    str.html_safe
  end

  def friend_button()
  end
  
end
