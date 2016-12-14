module PhotosHelper
  def photo_liked_by_current_user(photo, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & photo.like_ids
      intersection.empty? ? false : true
    end
  end
end
