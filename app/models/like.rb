class Like < ApplicationRecord
  belongs_to :likable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:likable_type, :likable_id] }
  validates :user_id, :likable_type, :likable_id, presence: true
end
