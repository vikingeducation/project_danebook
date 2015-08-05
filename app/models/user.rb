class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, dependent: :destroy


  has_secure_password

  validates :password,  :presence => true,
                        :length => {:in => 4..24},
                        :allow_nil => true

  validates :email,     :presence => true,
                        :format => {:with => /@/},
                        :uniqueness => true,
                        :length => {:in => 4..24}
  
  after_create :create_profile

  def full_name
      self.first_name + " " + self.last_name
  end

end
