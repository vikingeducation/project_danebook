class Post < ApplicationRecord
  belongs_to :author, :class_name => "User", :inverse_of => :posts
  has_many :likes, :as => :likable
  has_many :likers, :through => :likes

  has_many :comments, :as => :commentable, :inverse_of => :commentable
  has_many :commenters, :through => :comments
  accepts_nested_attributes_for :comments,
                              :reject_if => :all_blank,
                              :allow_destroy => true
end
