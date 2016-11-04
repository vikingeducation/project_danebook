class Like < ApplicationRecord
  validates_uniqueness_of :user_id, scope: [:likeable_id, :likeable_type]

  belongs_to :likeable, polymorphic: true
  belongs_to :user
end
