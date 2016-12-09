class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_one :profile, inverse_of: :user
  has_many :posts

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
