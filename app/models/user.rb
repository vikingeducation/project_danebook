class User < ActiveRecord::Base
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :password,
            :length => {:in => 6..15}
  validates :password, :first_name, :last_name, :gender, :birthday, :email,
            :presence => true
  validates :email,
            :uniqueness => :true
  validates :first_name, :last_name,
            :length => {:in => 2..20}

  def full_name
    first_name + " " + last_name
  end
end
