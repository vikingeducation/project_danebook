module CommentsHelper

'<div class="like-area"><a href="#" class="like pull-left"></a>3 other people like this<a href="#" class="delete pull-right"></a></div>'

  def show_comment_likes(item)
    likes = item.likes 
    user = likes.last.user unless likes.last == nil
    user = likes[-2].user if user == current_user unless likes[-2] == nil
    if likes.where(user_id: current_user.id).any? && likes.count == 1
      str = "<div id='adjust'><a href= '#{user_path(current_user)}'>You</a>like this</div>"
    elsif likes.where(user_id: current_user.id).any? && likes.count > 2
      str = "<div id='adjust'>You and <a href= '#{user_path(user)}'>#{user.first_name} #{user.last_name}</a>and #{likes.count - 2} others like this</div>"
    elsif likes.where(user_id: current_user.id).any? && likes.count == 2
      str = "<div id='adjust'>You and <a href= '#{user_path(user)}'>#{user.first_name} #{user.last_name}</a>like this</div>"
    elsif likes.count == 1
      str = "<div id='adjust'><a href= '#{user_path(user)}'> #{user.first_name} #{user.last_name}</a>likes this</div>"
    elsif likes.count == 0
      str = ""
    else
      str = "<div id='adjust'><a href= '#{user_path(user)}'> #{user.first_name} #{user.last_name}</a>and #{likes.count - 1} others like this</div>"
    end 
    str.html_safe
  end
end
