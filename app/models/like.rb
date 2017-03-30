class Like < ApplicationRecord

  belongs_to :likable, polymorphic: true

  belongs_to :user
  belongs_to :liker, foreign_key: :user_id, class_name: "User"

  validates :user, uniqueness: { scope: [:likable_id, :likable_type] }
  validates :user, :likable, presence: true
  validates :likable_type, inclusion: ["Post", "Comment", "Photo"]

  LIKABLES = [:posts, :comments, :photos]
end
