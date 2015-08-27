class Post < ActiveRecord::Base

  belongs_to :poster, :class_name => 'User'

  has_many :likes, :as => :liked, :dependent => :destroy
  has_many :likers, :through => :likes, :source => :user

  has_many :comments, :as => :commentable, :dependent => :destroy

  validates :body, :poster_id, :presence => :true
  validates :body, :length => { in: 1..255 }

end
