class Comment < ApplicationRecord
  has_many :likes, :as => :likeable
  validates :body, presence: true

  belongs_to :commentable, :polymorphic => true
end
