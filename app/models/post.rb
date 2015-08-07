class Post < ActiveRecord::Base

  belongs_to :author, :class_name => 'User', :foreign_key => :author_id

  has_many :likes, :foreign_key => :liked_id, :dependent => :destroy
  has_many :likers, :through => :likes, :source => :user

  has_many :comments, :dependent => :destroy

  validates :body, :author_id, :presence => :true
  validates :body, :length => { in: 1..255 }



end
