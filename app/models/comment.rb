class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :likes, as: :likable, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  validates :body, :commentable, :user, presence: true
  validates :commentable_type, inclusion: ["Post", "Photo"]
  validates :body, length: { maximum: 500 }

end
