class Post < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: "User"
  has_many :likes, foreign_key: :liked_post_id, class_name: "Like"
end
