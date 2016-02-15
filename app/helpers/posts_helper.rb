module PostsHelper

  def post_like_unlike_link(post)
    
    like = post.liked_by_user(current_user)[0]

    num_likes = post.likes.count

    if !like
      str = link_to("Like", user_post_likes_path(@user.id, post.id), 
                   method: :post)
    else
      str = link_to("Unlike", 
               user_post_like_path(@user.id, post.id, like.id), 
                   method: :delete)
    end
    str.html_safe

  end
    
  #Generates the string of how many likes by other users  
  def show_post_likes(post)

    num_likes = post.likes.count 
    
    if num_likes == 1
      other_user_like = 
        post.liked_by_other_users(current_user.id)[0] 
      
      if other_user_like
        first_user = other_user_like.liked_by.profile 
        str = link_to("#{first_user.first_name} #{first_user.last_name} likes this",
                      user_path(first_user.id))
      end

    elsif num_likes > 1

      first_user = post.liked_by_other_users(current_user.id)[0].liked_by.profile
      str = link_to("#{first_user.first_name}  #{first_user.last_name} and
                    #{pluralize((num_likes - 1), "other")} like this",
                    user_path(first_user.id))
    end
 
  end

end