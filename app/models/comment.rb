class Comment < ApplicationRecord
  belongs_to :user , foreign_key: :user_id
  has_many :likes, as: :likeable, dependent: :destroy 
  belongs_to :commentable, :polymorphic => true
end
