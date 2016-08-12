class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # a user can only like a particular post once
  validates :user_id, uniqueness: {:scope => [:post_id]}
end
