class Post < ApplicationRecord
  belongs_to :author, :foreign_key => :post_author_id, :class_name => "user"
  belongs_to :receiver, :foreign_key => :post_receiver_id, :class_name => "User"
  belongs_to :postable, :polymorphic => true
  has_many :comments, :as => :commentable
  has_many :likes, :as => :commentable
end
