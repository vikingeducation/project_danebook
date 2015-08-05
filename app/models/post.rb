class Post < ActiveRecord::Base

  belongs_to :profile
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def already_liked_by?(current_user)
    return false unless current_user
    self.likes.where(:user_id => current_user.id).count > 0
  end

end
