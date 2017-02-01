module UsersHelper

  def user_link(user)
    if user == current_user
      "You"
    elsif user
      link_to user.name, user
    end
  end

  def cover_pic(user)
    photo = Photo.where(id: user.profile.cover_id)
    if photo.empty?
      image_tag('hogwarts_small.jpg', width: '100%', height: '350px', class: "cover-photo hidden-sm hidden-xs")
    else
      image_tag(photo[0].image.url)
    end
  end

end
