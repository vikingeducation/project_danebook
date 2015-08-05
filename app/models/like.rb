class Like < ActiveRecord::Base
  belongs_to :likeable, :polymorphic => true
  belongs_to :user
  validates :user_id, uniqueness: { scope: [:likeable_id, :likeable_type] }

  def profile
    self.likeable.profile_id
  end
end
