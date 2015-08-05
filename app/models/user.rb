class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_secure_password

  validates :password,  :presence => true,
                        :length => {:in => 4..24},
                        :allow_nil => true

  validates :email,     :presence => true,
                        :format => {:with => /@/},
                        :uniqueness => true,
                        :length => {:in => 4..24}
  
  after_create :create_profile

 

end
