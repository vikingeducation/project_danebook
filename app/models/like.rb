class Like < ApplicationRecord
  belongs_to :likeable, :polymorphic => true
  belongs_to :user

  validates :user, presence: true
  validates :likeable, presence: true
end
