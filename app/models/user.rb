class User < ApplicationRecord
  before_create :generate_token

  after_save { email.downcase.strip }

  has_many :posts, dependent: :nullify
  has_one :profile, inverse_of: :user


  accepts_nested_attributes_for :profile
  has_secure_password

  validates :password,
  length: { minimum: 6 },
  allow_nil: true

  validates :email, presence: true,
                    length: { maximum: 255 },
                    :format => /@/,
                    uniqueness: { case_sensitive: false }


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
