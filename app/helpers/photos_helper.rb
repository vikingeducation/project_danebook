module PhotosHelper

  def photo_num
    num = page_owner.photos.size
    num > 0 ? "(#{num.to_s})"  : ""
  end

  def profile_pic_display
    user = page_owner

    if user.profile_photo
      image_tag user.profile_photo.picture.expiring_url(10, :thumb),
          class: "img-responsive",
          id: user.profile_photo.picture_file_name + "_profile"

    else
      #current default
      image_tag "harry_potter_small.jpg", class: "img-responsive",
                                              id: "default-photo"
    end
  end

  def cover_pic_display
    user = page_owner

    if user.cover_photo
      image_tag user.cover_photo.picture.expiring_url(10),
          class: "img-responsive",
          id: user.cover_photo.picture_file_name + "_cover"
    else
      #current default
      image_tag "hogwarts_small.jpg", class: "img-responsive",
                                          id: "cover-photo"
    end
  end

  #if no photos, do not display widget on timeline
  def photos_widget
    if @photos.any?
      render partial: 'photo_panel'
    end
  end
end
