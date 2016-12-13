class Like < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :likeable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type]}
end
