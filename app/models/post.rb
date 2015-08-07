class Post < ActiveRecord::Base
  belongs_to :user 
  belongs_to :profile
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, length: {minimum: 1}
  validates :user_id, presence: true
  validates :profile_id, presence: true

  def already_liked_by?(current_user)
    return false unless current_user
    self.likes.where(:user_id => current_user.id).count > 0
  end

end
