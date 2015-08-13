class Like < ActiveRecord::Base
  validates :user_id, :likable_id, :likable_type, presence: true
  validates :user_id, uniqueness: { scope: [:likable_id, :likable_type] }

  belongs_to :user
  has_one :profile, through: :user

  belongs_to :likable, :polymorphic => true

end
