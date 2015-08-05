class User < ActiveRecord::Base
  has_secure_password
  has_one :profile
  has_many :posts
  validates :password,
            :length => {:in => 6..15}
end
