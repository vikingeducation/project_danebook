module UsersHelper

  def about_page_action
    if @user == current_user
      link_to "Edit your profile", edit_user_path(current_user), class: "btn btn-primary btn-sm pull-right", alt: "Edit your profile"
    elsif current_user.friended_users.include?(@user)
      link_to "Unfriend", user_friend_path(current_user, @user), method: 'delete', class: "btn btn-danger btn-sm pull-right", alt: "Unfriend #{@user.profile.full_name}"
    else
      link_to "Friend Me", user_friends_path(current_user, :recipient_id => @user.id), method: 'post', class: "btn btn-primary btn-sm pull-right", alt: "Add #{@user.profile.full_name} as a Friend"
    end
  end


  def user_show_field(label, field)
    unless field.nil? || field.empty?
      "<dt>#{label}:</dt>
      <dd>#{field}</dd>".html_safe
    end
  end


  def user_show_text(label, field)
    unless field.nil? || field.empty?
      "<h3>#{label}</h3>
      <p>#{field}</p>".html_safe
    end
  end


end
