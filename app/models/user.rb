class User < ApplicationRecord
  has_secure_password
  before_create :generate_token

  validates :password, 
            :length => {:in => 8..24}, 
            :allow_nil => true

  validates_format_of :email, :with => /@/

  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile

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
