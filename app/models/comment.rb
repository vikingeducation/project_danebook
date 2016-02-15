class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 500 }
end
