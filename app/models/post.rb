class Post < ApplicationRecord
  include AllFriendPosts
  belongs_to :author, foreign_key: :author_id, class_name: "User"
  has_many :likes, as: :likable_thing, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, length: { in: 1..5000 }

end