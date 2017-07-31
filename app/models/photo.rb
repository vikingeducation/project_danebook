class Photo < ApplicationRecord

  has_many :users
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user

  validates_presence_of(:user)

end
