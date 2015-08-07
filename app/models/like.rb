class Like < ActiveRecord::Base
  validates :user, :likable_id, :likable_type, presence: :true
  validates :user_id, uniqueness: { scope: [:likable_type, :likable_id]}
  belongs_to :user
  belongs_to :likable, polymorphic: true
end
