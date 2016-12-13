module PostsHelper

  def display_delete(user,p)
    str = ""
    if current_user == user
      str += link_to 'Delete', user_post_path(user, p), method: :delete
    end
    str.html_safe
  end

end
