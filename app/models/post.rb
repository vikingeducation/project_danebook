class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 2000 }
  validates :user, presence: true
end
