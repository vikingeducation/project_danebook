class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :password,
            :length => {:within => 6..25},
            :allow_nil => true
end
