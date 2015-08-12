module PhotosHelper

  def photo_num
    num = User.find(params[:user_id]).photos.size
    num > 0 ? "(#{num.to_s})"  : ""
  end

  def profile_pic_display
    user = params[:user_id]
    if user.profile_photo_id
      image_tag user.profile_photo, class: "img-responsive", id: user.profile_photo.picture_file_name + "_profile"
    else
      image_tag "harry_potter_small.jpg", class: "img-responsive", id: "default-photo"
    end
  end

  def cover_pic_display
    user = params[:user_id]
    if user.profile_photo_id
      image_tag user.cover_photo, class: "img-responsive", id: user.cover_photo.picture_file_name + "_cover"
    else
      image_tag "hogwarts_small.jpg", class: "img-responsive", id: "cover-photo"
    end
  end
end
