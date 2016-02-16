module ApplicationHelper


  def field_with_errors(object, field)

    unless object.errors[field].empty?
      content_tag(:div, class: "bg-danger") do
        "#{field.to_s.titleize} #{object.errors[field].first}"
      end
    end
  end


  def friend_or_unfriend(user)
    if current_user && current_user.friended_users.include?(user)
      button_to "Remove Friend", user_friending_path(current_user, profile.user), class: "btn btn-primary"
    end
  end 


end
