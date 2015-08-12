class Comment < ActiveRecord::Base

  belongs_to :post
  belongs_to :comment
  belongs_to :user
  belongs_to :photo
  has_many :likes, as: :likeable

  belongs_to :commentable, :polymorphic => true

  validates :body, presence: true
end
