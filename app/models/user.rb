class User < ActiveRecord::Base
  belongs_to :gender

  has_secure_password

  validates :email,
            :presence => true,
            :format => /@/

  validates :password,
            :length => {:in => 8..32},
            :format => {:without => /\s/},
            :allow_nil => true

  validates :first_name,
            :presence => true,
            :format => {:with => /[a-zA-Z]+/}

  validates :last_name,
            :presence => true,
            :format => {:with => /[a-zA-Z]+/}

  validates :birthday,
            :presence => true

  validates :gender,
            :presence => true
end
