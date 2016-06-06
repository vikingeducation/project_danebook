class User < ActiveRecord::Base
  has_secure_password

  validates :password,
            :length => { in: 8..24 }

  validates :email, format: { with: /@/, message: "Please enter a valid email" }
end
