module PhotosHelper
  def cover_photo(user)
    if user.cover_photo
      image_tag user.cover_photo.photo.url(:original), alt: "Cover Photo", class: "hero-image"
    else
      image_tag "hogwarts_small.jpg", :alt => "Hogwarts Castle", class: "hero-image"
    end
  end

  def profile_photo(user, size, css_class=nil)
    if user.profile_photo
      image_tag user.profile_photo.photo.url(size), alt: "#{user.name}", class: css_class
    else
      image_tag "user_silhouette_generic.gif", :alt => "#{user.name}", class: css_class
    end
  end

  def set_photo_bar(user)
    if user == current_user
      render "set_photo_bar"
    end
  end

  def random_photos(user)
    if user.photos.count <= 9
      user.photos
    else
      user.photos.shuffle[0..8]
    end
  end
end
