class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password, presence: true, length: {in: 8..24}, confirmation: true


end
