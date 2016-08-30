class Comment < ApplicationRecord
  has_many :likes, :as => :likable
  has_many :likers, :through => :likes

  belongs_to :commentable, :polymorphic => true
  belongs_to :commenter, :class_name => "User", :inverse_of => :comments
end
