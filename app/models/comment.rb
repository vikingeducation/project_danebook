class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 500 }
  validates :user, presence: true
  validates :commentable, presence: true
end
