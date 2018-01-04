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
      image_tag 'http://lorempixel.com/150/150/people'
    else
      image_tag user.headshot_pic, alt: 'Profile Pic'
    end
  end

  def display_cover_pic(user)
    if user.cover_pic.blank?
      image_tag 'http://lorempixel.com/770/230/nature'
    else
      image_tag user.cover_pic, alt: "Cover Photo"
    end
  end

end
