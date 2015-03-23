class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes

  accepts_nested_attributes_for :profile, :posts

  validates :password,
            :length => {:within => 6..25},
            :allow_nil => true
end
