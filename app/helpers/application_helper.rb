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

  def like_links(object)
    if object.likes.include_user?(current_user)
      str = link_to "Like", likes_path( :like => {likeable_id: object.id, likeable_type: object.class, user_id: current_user.id} ), method: :post
    else
      str = link_to "Unlike", like_path(object.likes.where(:user_id=>current_user.id)[0]), method: :delete
    end
    str.html_safe
  end

  def user_like_info(object)
    if object.likes.length > 0
      string = '<div class="row"><div class="col-xs-12">'
      if object.likes.length == 1
        string += "#{object.likes[0].user.full_name} likes this"
      elsif object.likes.length < 4 && object.likes.length > 1
        object.likes.each do |like|

          string += "#{like.user.full_name} and "
        end
        string = string[0..-4]
        string += "like this"
      else
        string = "#{object.likes.length} others like this"
      end
      string += "</div></div>"
      string.html_safe
    end

  end

  # % current_user.friends.each do |friend| %>
  #               <% if friend.friend_id == @profile.user.id %>
  #                 <%= link_to "Unfriend", friending_path(:id => @profile.user.id), method: :delete, :class=>"btn btn-primary"  %>
  #               <% elsif index == current_user.friends.length %>
  #                 <%= link_to "Friend", friendings_path(:friend_id => @profile.user.id), method: :post, :class=>"btn btn-primary"  %>
  #               <% end %>
  #               <% index += 1 %>
  #             <% end %>
  #           <% end %>

  def friend_links(user)
    friend_bool = false
    string = ""
    current_user.friends.each do |friend|
      if friend.friend_id == user.id
        friend_bool = true
        string = link_to "Unfriend", friending_path(:id => user.id), method: :delete, :class=>"btn btn-primary"
      end
    end
    if friend_bool == false
      string = link_to "Friend", friendings_path(:friend_id => user.id), method: :post, :class=>"btn btn-primary"
    end
    string.html_safe
  end

end
