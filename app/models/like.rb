class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count
  belongs_to :user
  has_one :activity, as: :activable, dependent: :destroy
  after_create :create_activity_feed_record

  validates :user, uniqueness: { scope: [:likeable_type, :likeable_id]}

  include Reusable

end
