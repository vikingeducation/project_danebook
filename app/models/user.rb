class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :profile, :posts, :likes
  validates :email, :uniqueness => true
  validates :password,
            :length => {:within => 6..25},
            :allow_nil => true
end
