class Comment < ApplicationRecord
  belongs_to :user, :foreign_key => :user_id
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable

end
