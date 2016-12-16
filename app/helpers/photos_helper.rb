module PhotosHelper
  def photo_liked_by_current_user(photo_likes, current_user_likes)
    if current_user && current_user_likes
      intersection = current_user_likes.pluck(:id) & photo_likes.pluck(:id)
      intersection.empty? ? false : true
    end
  end
end
