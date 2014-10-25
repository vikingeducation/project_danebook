module ApplicationHelper

  def current_user_page(user)
    user != nil && user == current_user
  end

  def like_link(post)

    if current_user.likes_post?(post)
      like = current_user.like_of_post(post)
      link_to "Unlike", [post.user, post, like], method: "delete", class: "col-md-1"
    else
      link_to "Like", [post.user, post, :likes], method: "post", class: "col-md-1"
    end
  end

end
