class Like < ActiveRecord::Base
  belongs_to :likable, :polymorphic => true
  belongs_to :user

  validates :user_id, :uniqueness => { scope: [:likable_id, :likable_type] }
end
