class Comment < ActiveRecord::Base
  belongs_to :user

  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :likers, :through => :likes, :source => :user
end