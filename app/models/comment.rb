class Comment < ActiveRecord::Base
 
  belongs_to :commentable, :polymorphic => true
  belongs_to :author, class_name: 'User' 

  has_many :comments, :as => :commentable
  has_many :comment_likes,
           class_name: "Like", 
           :as => :duty,
           :dependent => :destroy

  validates :commentable_id, :commentable_type, :body, :user_id,
            :presence => :true

  validates :body, :format => {:with => /[a-zA-Z]+/}
end
