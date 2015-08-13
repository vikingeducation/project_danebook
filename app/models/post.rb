 class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable
  has_many :post_likes,
           class_name: "Like", 
           :as => :duty,
           :dependent => :destroy
  
  validates :body, :user_id, :presence => :true
  validates :body, :format => {:with => /[a-zA-Z]+/}

end
