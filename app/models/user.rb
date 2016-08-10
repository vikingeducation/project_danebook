class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true, length: { in: 8..24}
end
