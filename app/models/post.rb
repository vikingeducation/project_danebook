class Post < ActiveRecord::Base
  include Dateable
  include Feedable

  feedable_user_methods :user
  feedable_actions :create

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates :body,
            :presence => true

  validates :user,
            :presence => true
end
