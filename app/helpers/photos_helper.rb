module PhotosHelper

  def photos_grouped_by_fours(photos)
    @grouped_photos = photos.in_groups_of(4, false)
  end
end
