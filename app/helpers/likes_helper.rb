module LikesHelper

  def display_likes

    # if you haven't like this yet, display 'like'
    # if you have liked this, display unlike

    if current_user_has_liked?
      str = "<%= link_to 'Like', user_posts_likes_path, method: :post %>"
    else
    end
    str.html_safe

    
  end

end
