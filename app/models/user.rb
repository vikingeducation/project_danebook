class User < ActiveRecord::Base
  belongs_to :gender

  has_secure_password

  validates :email,
            :presence => true,
            :uniqueness => true,
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

  def create_auth_token
    str = SecureRandom.uuid
    str += persisted? ? email : ''
    auth_token = SecureRandom.urlsafe_base64 + Base64.urlsafe_encode64(str)
    update!(:auth_token => auth_token)
    auth_token
  end
end
