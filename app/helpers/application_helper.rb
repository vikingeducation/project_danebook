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

  def like_sentence(post)
    return nil unless post
    sentence = ""

    case post.likes.size
    when 0
      return ""
    when 1
      sentence << "#{user_link(post.users_who_liked.first)}".html_safe
    when 2
      sentence << "#{user_link(post.users_who_liked.first)} and #{user_link(post.users_who_liked.second)}".html_safe
    else
      sentence << "#{user_link(post.users_who_liked.first).upcase}. and #{user_link(post.users_who_liked.second).downcase} and #{post.likes.size - 2} other users".html_safe
    end
    sentence << " liked this post."
  end

  def user_link(user)
    if user == current_user
      "you"
    elsif user
      link_to user.name, user
    end
  end


end
