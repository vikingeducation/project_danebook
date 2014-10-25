class User < ActiveRecord::Base

  has_secure_password

  validates :password,
            :length => { in: 8..24 },
            allow_nil: true

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :posts

  before_create :generate_token

  #create new auth token
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Convenience method to regenerate token.
  # Failing with exception is important because it implies tampering.
  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def name
    "#{first_name} #{last_name}"
  end

end
