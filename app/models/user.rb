class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, :last_name, :email,
            :length => { :in => 1..30 },
            :presence => true

  validates :email,
            :format => { :with => /@/ }

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  def name
    "#{first_name} #{last_name}"
  end

end
