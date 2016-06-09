class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w\d\.\_]{4,254}@\w{,6}\.\w{3}\z/

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :first_name, :last_name, :email
  validates :email, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
