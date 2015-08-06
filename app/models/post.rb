class Post < ActiveRecord::Base
  belongs_to :user

  has_many :comments, :dependent => :destroy
  has_many :likes, :as => :likable, :dependent => :destroy
  
end
