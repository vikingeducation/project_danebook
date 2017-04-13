class User < ApplicationRecord
  has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile
  validates :email, presence: true, uniqueness: true, length: { minimum: 6}
  validates :password, :password_confirmation, presence: true, length: {minimum: 12 }, on: :create
  validates_associated :profile

  def first_name
    profile.first_name
  end

  def birthday
    self.profile.birthdate.strftime('%B %e, %Y')
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end


end
