module PhotosHelper

  def render_photo_container(photo)
    render partial: "shared/photo_container", locals: { photo: photo }
  end

  def photos_count_check(photos,max_rows=5)
    len = photos.length
    mid = max_rows-1
    len > max_rows ? [photos[0..mid],photos[5..len-1]] : [photos[0..len-1]]
  end

  def render_timeline_photo(photo)
    render partial: "shared/timeline_photo", locals: { photo: photo }
  end

end
