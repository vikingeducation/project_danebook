class Post < ActiveRecord::Base

	belongs_to :user

	# has_many :likes, as: :likable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author_id, :body, presence: true
end