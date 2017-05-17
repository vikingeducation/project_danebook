module PhotosHelper

  def photo_link(photo)
    if current_user.friends?(photo.user.id) || photo.user == current_user
      link_to image_tag(photo.image.url(:medium)), user_photo_path(photo.user, photo)
    else
      image_tag(photo.image.url(:medium))
    end
  end

  def profile_photo(user, style='medium')
    if user.profile_photo.nil? 
      image_tag 'default.jpg'
    else 
      image_tag user.profile_photo.image.url(style.to_sym) 
    end
  end

  def cover_photo(user)
    if user.cover_photo.nil?
      image_tag 'default.jpg', class: "img-responsive"
    else
      image_tag user.cover_photo.image.url
    end
  end


end


