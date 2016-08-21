class Comment < ApplicationRecord
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :user, presence: true
  validates :commentable, presence: true

  has_many :comments, as: :commentable
  has_many :commenters, through: :comments, source: :user

  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user

  validates :description, length: { in: 1..500 }
  validates :user, presence: true
  validates :commentable, presence: true
end
