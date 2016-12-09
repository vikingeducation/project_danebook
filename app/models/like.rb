class Like < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :posts, foreign_key: :thing_id
end
