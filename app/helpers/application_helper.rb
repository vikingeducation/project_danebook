module ApplicationHelper

  def like_button(likable_id, likable_type)
    if current_user.like?(likable_id, likable_type)
      str = link_to("Unlike", 
                    like_path(current_user.get_like_id(likable_id, likable_type)), 
                    method: :delete)
    else
      str = link_to("Like", 
                    likes_path(user_id: current_user.id,
                               likable_id: likable_id,
                               likable_type: likable_type), 
                    method: :post)
    end
    str.html_safe
  end
  
end
