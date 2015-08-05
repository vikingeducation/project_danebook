class Comment < ActiveRecord::Base

  belongs_to :post
  belongs_to :comment
  belongs_to :user

  belongs_to :commentable, :polymorphic => true
end
