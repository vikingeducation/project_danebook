class Comment < ActiveRecord::Base

  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :commentable_id, :commentable_type, :body, :user_id,
            :presence => :true

end
