module CommentsHelper


  def comment_like_unlike_link(comment)
    
    like = comment.liked_by_user(current_user)[0]

    num_likes = comment.likes.count

    if !like
      str = link_to("Like", likes_path(likeable_id: comment.id, user_id: comment.user_id,  likeable_type: comment.class), method: :post)
    else
      str = link_to("Unlike", 
            like_path(id: like.id, user_id: comment.user_id), method: :delete)
    end
    str.html_safe

  end
    
  #Generates the string of how many likes by other users  
  def show_comment_likes(comment)

    other_users = comment.liked_by_other_users(current_user.id)
    num_likes   = other_users.size
    other_user = other_users[0].profile if num_likes > 0

    if num_likes == 1
      
      str = link_to("#{other_user.first_name} #{other_user.last_name} likes this",
                    user_path(other_user.id))
    elsif num_likes > 1
       
      str = link_to("#{other_user.first_name}  #{other_user.last_name} and
                    #{pluralize((num_likes - 1), "other")} like this",
                    user_path(other_user.id))
    end
 
  end

end
