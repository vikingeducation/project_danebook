class User < ApplicationRecord
  before_create :generate_token
  has_secure_password

  validates :password, :length => { :in => 8..24 },
                       :allow_nil => true

  validates :words_to_live_by, :about, :length => { minimum: 10 }, allow_nil: true
  validates :email, uniqueness: true
end
