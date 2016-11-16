class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  # a user can only like a particular post or comment once
  validates :user_id, uniqueness: {:scope => [:likeable_id, :likeable_type]}
end
