module UsersHelper
  def field_with_errors(object,field)

    # No errors if no errors!
    if object.errors[field].empty?
      error = ""
    else
      # Otherwise, create an error <div> around the message
      error = content_tag(:div, :class=>"error") do
        field.to_s.titleize + " " + object.errors[field].first
      end
    end
  end

  def profile_helper(field)
    if field && !field.blank?
      field
    else
      "This user has not yet added this information!"
    end
  end

  def friend_button
    unless current_user.nil? || on_own_page
      if can_friend
        return link_to "Friend", friendings_path(id: @user.id), method: 'post', class: "btn btn-primary"
      else
        return link_to "Unfriend", friendings_path(id: @user.id), method: 'delete', class: "btn btn-primary"
      end
    end
  end

  def can_friend
    !current_user.friend_ids.include? (@user.id)
  end

  def on_own_page
    current_user.id == @user.id
  end
end
