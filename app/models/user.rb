class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password, presence: true, length: {in: 8..24}
end
