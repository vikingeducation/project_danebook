# Users Helper
module UsersHelper
  def profile_edit_link(user)
    if current_user == user
      link_to 'Edit Profile', edit_profile_path(current_user)
    end
  end

  def profile_pic(user)
    photo = Photo.where(id: user.profile.picture_id)
    if photo.empty?
      image_tag('user_silhouette_generic.gif', size: '100x100')
    else
      image_tag(photo[0].image.url(:thumb))
    end
  end
end
