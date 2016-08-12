class User < ApplicationRecord
  has_secure_password

  validates :username, length: { :minimum => 1}, uniqueness: true
  validates_format_of :email, :with => /@/
  validates :password, 
            :length => { :in => 5..24 }, 
            :allow_nil => true

  before_create :generate_token

  has_one :profile, class_name: "Profile"
  has_many :posts, class_name: "Post"

  #generates and regenerates tokens and sets to self
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
