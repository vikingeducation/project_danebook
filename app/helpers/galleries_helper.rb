module GalleriesHelper
  def gallery_cover(gallery)
    gallery.images.size == 0 ? (image_tag "//s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif") : (image_tag gallery.images.first.picture.url(:medium))
  end
end
