class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :likes, :as => :user_chat
  accepts_nested_attributes_for :comments
end
