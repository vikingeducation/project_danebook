module ApplicationHelper

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def like_links(post)
    if post.likes.include_user?(current_user)
      str = link_to "Like", likes_path(post_id:post.id), method: :post
    else
      str = link_to "Unlike", like_path(post.likes.where(:user_id=>current_user.id), post_id:post.id), method: :delete
    end
    str.html_safe
  end

  def user_like_info(post)
    if post.likes.length > 0
      string = '<div class="row"><div class="col-xs-12">'
      if post.likes.length == 1
        string += "#{post.likes[0].user.full_name} likes this"
      elsif post.likes.length < 4 && post.likes.length > 1
        post.likes.each do |like|

          string += "#{like.user.full_name} and"
        end
        string = string[0..-4]
        string += "like this"
      else
        string = "#{post.likes.length} others like this"
      end
      string += "</div></div>"
      string.html_safe
    end

  end

end
