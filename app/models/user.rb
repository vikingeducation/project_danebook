class User < ApplicationRecord
  has_secure_password

  validates :password, 
            :length => { :in => 8..24 }, 
            :allow_nil => true

  before_create :generate_token

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
