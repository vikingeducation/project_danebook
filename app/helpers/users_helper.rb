module UsersHelper
  
  def like_or_unlike(object)
    current_user.likes do |like|
      if like.duty_id == obj.id 
        link = link_to "Unlike", like_path(object.likes.where(:user_id=>current_user.id)[0]), method: :delete
      end
    end
     link = link_to "Like", like_path( :like => {duty_id: object.id, duty_type: object.class, user_id: current_user.id} ), method: :post
     return link.html_safe
  end

end


