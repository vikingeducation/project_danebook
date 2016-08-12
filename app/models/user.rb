class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password
  validates :email, presence: true
  validates :password_digest, presence: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  def to_s
    profile.first_name + " " + profile.last_name
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
