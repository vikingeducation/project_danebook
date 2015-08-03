class User < ActiveRecord::Base
  has_secure_password
  validates :password,
            :length => {:in => 6..15}
end
