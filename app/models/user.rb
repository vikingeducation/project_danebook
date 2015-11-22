class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  belongs_to :gender
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

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
            :format => {:with => /\A[a-zA-Z]+\z/}

  validates :last_name,
            :presence => true,
            :format => {:with => /\A[a-zA-Z]+\z/}

  validates :birthday,
            :presence => true

  validates :gender,
            :presence => true

  accepts_nested_attributes_for :profile

  before_create :create_profile

  def name
    "#{first_name} #{last_name}"
  end

  def create_auth_token
    update!(:auth_token => generate_auth_token)
    auth_token
  end


  private
  def generate_auth_token
    str = SecureRandom.uuid
    str += persisted? ? email : Time.now.to_s
    SecureRandom.urlsafe_base64 + Base64.urlsafe_encode64(str)
  end
end


