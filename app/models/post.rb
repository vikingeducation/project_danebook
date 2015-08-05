class Post < ActiveRecord::Base
  belongs_to :profile
  has_many :likes, as: :likeable, dependent: :destroy

  def already_liked_by?(current_user)
    self.likes.where(:user_id => current_user.id).count > 0
  end

  def current_user_likes
    self.likes.where(:user_id => current_user.id).first
end
