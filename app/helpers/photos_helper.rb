module PhotosHelper

  def display_cover_photo
    if object_owner.profile.cover_photo
      image_tag(object_owner.profile.cover_photo.image.url, class: 'img-responsive cover-photo hidden-xs hidden-sm').html_safe
    else
      asset_path 'blank_cover_photo.jpg'
    end
  end

  def display_profile_photo
    if object_owner.profile.cover_photo
      image_tag(object_owner.profile.profile_photo.image.url, class: 'img-responsive hidden-xs hidden-sm')
    else
      asset_path 'blank_profile_photo.jpg'
    end
  end

end
