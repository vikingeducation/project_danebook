module PhotosHelper

  def profile_photo_or_default(photo)
    if photo
      photo.asset.url(:medium)
    else
      "https://s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
    end
  end

  def cover_photo_or_default(photo)
    if photo
      photo.asset.url
    else
      'https://s3.amazonaws.com/viking_education/web_development/web_app_eng/hogwarts_small.jpg'
    end
  end

end
