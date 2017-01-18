module PostsHelper

  def show_post_likes(item)

    likes = item.likes 
    user = likes.last.user unless likes.last == nil
    user = likes[-1].user if user == current_user unless likes[-1] == nil
    if likes.where(user_id: current_user.id).any? && likes.count == 1
      str = "<div class='liked-box'> <a href= '#{user_path(user)}' class='liking'> You</a><p>like this </p></div>"
    elsif likes.where(user_id: current_user.id).any? && likes.count == 2
      str = "<div class='liked-box'>  You and<a href= '#{user_path(user)}' class='liking'>  #{user.first_name} #{user.last_name}</a><p> like this </p></div>"

    elsif likes.where(user_id: current_user.id).any? && likes.count > 2
      str = "<div class='liked-box'>  You and <a href= '#{user_path(user)}' class='liking'>  #{user.first_name} #{user.last_name} </a> <p> and #{likes.count - 2} others like this </p></div>"

    elsif likes.count == 1
      str = "<div class='liked-box'> <a href= '#{user_path(user)}' class='liking'>  #{user.first_name} #{user.last_name} </a><p>likes this </p></div>"
    elsif likes.count == 0
      str = ""
    else
      str = "<div class='liked-box'> <a href= '#{user_path(user)}' class='liking'>  #{user.first_name} #{user.last_name} </a><p>and #{likes.count - 1} others like this </p></div>"
    end 
    str.html_safe
  end

end
