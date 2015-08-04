class User < ActiveRecord::Base
  has_one :profile

  has_secure_password

  before_create :generate_token


  def generate_token
    begin 
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token]) 
  end

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end
end
