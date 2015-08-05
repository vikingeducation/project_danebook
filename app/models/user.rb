class User < ActiveRecord::Base

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_secure_password

  validates :password,
            :length => { :in => 6..24 },
            :allow_nil => true
end
