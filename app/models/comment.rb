class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable
end
