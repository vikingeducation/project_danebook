class User < ApplicationRecord
  has_secure_password
  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile
  validates :email, presence: true,  length: { minimum: 6}
  validates :password, :password_confirmation, presence: true, length: {minimum: 12 }
  validates_associated :profile

  def first_name
    profile.first_name
  end


end
