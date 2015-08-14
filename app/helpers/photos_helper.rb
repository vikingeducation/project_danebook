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
      image_tag(owner.profile.profile_photo.image.expiring_url(10), class: 'img-responsive hidden-xs hidden-sm').html_safe
    else
      image_tag('blank_profile_photo.jpg', class: 'img-responsive hidden-xs hidden-sm').html_safe
    end
  end

end