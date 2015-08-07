module UsersHelper
  
  def like_or_unlike(obj)
    like_obj = previous_liked(obj)
    if like_obj
      show_unlike(like_obj) 
    else
      show_like(obj)
    end
  end

  def show_unlike(like) 
    link_to("Unlike", unlike_path(:id => like.id, 
                                  :user_id => current_user.id), method: :delete)
  end

  def show_like(obj)
    link_to("Like", like_path(:like => {:user_id => current_user.id, 
                                        :duty_id => obj.id,
                                        :duty_type => obj.class,
                                        }), method: :post)
  end


  def previous_liked(obj)
    liked = Like.where(:duty_id => obj.id).
            where(:duty_type => obj.class).
            where(:user_id => current_user.id).first
    return liked
  end
end 


