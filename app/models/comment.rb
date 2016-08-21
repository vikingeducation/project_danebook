class Comment < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :commentable, polymorphic: true

  validates :comment_text, presence: true
end
