require 'active_support/concern'

module GetLikeID
  extend ActiveSupport::Concern

  def likes_by(user)
    likes.where(user_id: user.id).includes(:user)
  end

  def liked_by?(user)
    likes_by(user).any?
  end

  def get_id_of_the_like_by(user)
    liked_by?(user) ? likes_by(user).pluck(:id)[0] : nil
  end
end