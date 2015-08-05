class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :likes, as: :likeable

  def already_liked_by?(current_user)
    return false unless current_user
    self.likes.where(:user_id => current_user.id).count > 0
  end

end
