module LikesHelper
  def liked?(likable)
    !!likable.likes.find_by(user_id: current_user.id)
  end

  def find_like(likable)
    likable.likes.find_by(user_id: current_user.id)
  end
end
