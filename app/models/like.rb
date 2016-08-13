class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user
  # a user can only like a particular post once
  #validates :user_id, uniqueness: {:scope => [:post_id]}
end
