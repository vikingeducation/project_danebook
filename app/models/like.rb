class Like < ApplicationRecord

  ALLOWED_TYPES = ['Post', 'Comment']

  belongs_to :user

  belongs_to :likeable, :polymorphic => true

  validates :likeable_id, presence: true, numericality: { only_integer: true }
  validates :likeable_type, presence: true, inclusion: { in: ALLOWED_TYPES }

end
