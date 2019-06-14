module UsersHelper

  def display_stat(user, attribute)
    if user.send(attribute).blank? && user == current_user
      link_to "add #{attribute}", edit_user_path(user)
    else
      user.send(attribute)
    end
  end

  def display_profile_pic(user, photo_type)
    image_tag 'profile_pic_missing.jpg'

    # Image logic removed because of deleted S3 bucket
    # if user.profile_pic.blank?
    #   image_tag 'profile_pic_missing.jpg'
    # else
    #   image_tag user.profile_pic.photo_data.url(photo_type)
    # end
  end

  def display_cover_pic(user)
    image_tag 'cover_pic_missing.jpg'

    # Image logic removed because of deleted S3 bucket
    # if user.cover_pic.blank?
    #   image_tag 'cover_pic_missing.jpg'
    # else
    #   image_tag user.cover_pic.photo_data.url(:cover), alt: "Cover Photo"
    # end
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
