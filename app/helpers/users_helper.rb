module UsersHelper

  def display_stat(user, attribute)
    if user.send(attribute).blank? && user == current_user
      link_to "add #{attribute}", edit_user_path(user)
    else
      user.send(attribute)
    end
  end

  def display_headshot(user)
    if user.headshot_pic.blank?
      image_tag 'headshot-placeholder.png'
    else
      link_to (image_tag user.headshot_pic, alt: 'Profile Pic'), user_timeline_path(user)
    end
  end

  def display_cover_pic(user)
    if user.cover_pic.blank?
      image_tag 'cover-pic-placeholder.jpg'
    else
      image_tag user.cover_pic, alt: "Cover Photo"
    end
  end

  def friending_button(user)
    if current_user == user
    elsif current_user.friends.include?(user)
      link_to 'Unfriend', friending_path(id: user.id), method: :delete, data: {confirm: "Are you sure you want to unfriend #{user.name}?"}, class: button_classes('danger friend-link')
    else
      link_to '+ Add as Friend', friendings_path(id: user), method: :post, class: button_classes('primary friend-link')
    end

  end

end
