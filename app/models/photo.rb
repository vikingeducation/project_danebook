class Photo < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likable

  has_attached_file :asset, :styles => { :medium => "300x300", :thumb => "100x100" }
  validates_attachment_content_type :asset, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def liked_by_user?(user_id)
    self.likes.find_by(user_id: user_id)
  end
end
