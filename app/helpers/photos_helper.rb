module PhotosHelper

  def render_photo_container(photo)
    render partial: "shared/photo_container", locals: { photo: photo }
  end

  def photos_count_check(photos)
    len = photos.length
    len > 5 ? [photos[0..4],photos[5..len-1]] : [photos[0..len-1]]
  end

end
