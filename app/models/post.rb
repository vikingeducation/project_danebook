class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 1 }

  accepts_nested_attributes_for :comments

  def all_comments
    self.comments.order("created_at DESC")
  end
end
