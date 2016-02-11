class User < ActiveRecord::Base
  before_create :generate_token
  
  has_secure_password

  validates_presence_of :username,  uniqueness: true
  validates_presence_of :email,     uniqueness: true
  validates_format_of   :email,     without: /NOSPAM/
  validates :password,
            :length => {:in => 8..20},
            :allow_nil => true

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Make a convenience method for regenerating the token 
  # when we need it
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
