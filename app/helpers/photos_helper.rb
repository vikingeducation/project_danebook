module PhotosHelper


  # TODO: refactor this to be shared between photo, post, and comment
  def like_or_unlike(photo)
    # user already likes photo, show "Unlike" button
    if photo.likes.pluck(:user_id).include? current_user.id
      link_to("Unlike", user_photo_like_path(user_id: current_user.id, photo_id: photo.id, id: photo.likes.where(user_id: current_user.id).first.id), method: :delete)
    else
      link_to("Like", user_photo_likes_path(:like => { user_id: current_user.id, likeable_id: photo.id, likeable_type: photo.class.name, photo_id: photo.id }, photo_id: photo.id), method: :post)
    end
  end








end
