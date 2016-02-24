module PhotosHelper

  def liked_photo?(photo)
    return false unless signed_in_user?
    if photo.likes.any? { |l| l.user_id == current_user.id }
      return true
    else
      return false
    end
  end

  def get_like(photo)
    like = photo.likes.select { |l| l.user_id == current_user.id }
    return like
  end
end
