class User < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy, inverse_of: :user

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :password, length: { minimum: 8, maximum: 256 }, allow_nil: true

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
