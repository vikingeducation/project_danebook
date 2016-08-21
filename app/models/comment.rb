class Comment < ApplicationRecord
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user

  validates :description, length: { in: 1..500 }
end
