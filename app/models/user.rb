class User < ActiveRecord::Base

  has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :password, length: { in: 8..24 }, allow_nil: true
  validates :first_name, :last_name, :email, presence: true, length: { maximum: 36 }

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
