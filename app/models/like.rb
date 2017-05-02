class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count
  belongs_to :user

  validates :user, uniqueness: { scope: [:likeable_type, :likeable_id]}
end
