class Post < ApplicationRecord
  belongs_to :author, :foreign_key => :post_author_id, :class_name => "User"
  belongs_to :receiver, :foreign_key => :post_receiver_id, :class_name => "User", optional: true
  has_many :comments, :as => :commentable
  has_many :likes, :as => :likeable, :source => :likeable_id, source_type: "Comment"
  validates :body, presence: true




  
end
