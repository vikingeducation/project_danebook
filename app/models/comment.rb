class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  belongs_to :user

  validates :description, length: { in: 1..500 }
end
