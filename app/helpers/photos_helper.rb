module PhotosHelper

  def display_cover_photo(owner=object_owner)
    if owner.profile.cover_photo
      image_tag(owner.profile.cover_photo.image.expiring_url(10), class: 'img-responsive cover-photo hidden-xs hidden-sm').html_safe
    else
      image_tag('blank_cover_photo.jpg', class: 'img-responsive cover-photo hidden-xs hidden-sm').html_safe
    end
  end

  def display_profile_photo(owner=object_owner)
    if owner.profile.cover_photo
      image_tag(owner.profile.profile_photo.image.expiring_url(10), class: 'img-responsive').html_safe
    else
      image_tag('blank_profile_photo.jpg', class: 'img-responsive').html_safe
    end
  end

  def count_of_photos
    object_owner.photos.count
  end

  def display_grid_profile_photo(friendship)
    friend = user_thumb_to_display(friendship)
    link_to user_timeline_path(friend.id) do
      display_profile_photo(friend)
    end
  end

end