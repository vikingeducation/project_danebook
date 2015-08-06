class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :password,
            :length => {:in => 6..15}

  def full_name
    first_name + " " + last_name
  end
end
