module CommentsHelper

  def comment_like_unlike_link(post)
    
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


end
