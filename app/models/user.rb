class User < ApplicationRecord
  has_secure_password

  validates :email,
            presence: true,
            :uniqueness => true,
            :format => { :with => /@/ }

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  def display_name
    name.blank? ? email : name
  end

end
