class Post < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  validates :body, length: { minimum: 1 }
end
