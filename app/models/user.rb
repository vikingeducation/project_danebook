class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :received_posts, :class_name => "Post", :foreign_key => :receiver_id, dependent: :destroy
  has_many :authored_posts, :class_name => "Post", :foreign_key => :user_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :profile, :received_posts, :authored_posts, :likes
  validates :email, :uniqueness => true
  validates :password,
            :length => {:within => 6..25},
            :allow_nil => true
end
