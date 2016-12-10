class Like < ApplicationRecord
  belongs_to :liked_post, foreign_key: :liked_post_id, class_name: "Post"
  belongs_to :liker, foreign_key: :liker_id, class_name: "User"
end
