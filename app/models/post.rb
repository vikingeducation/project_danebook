class Post < ApplicationRecord

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates_presence_of(:user)

  validates :body, :presence => true
end
