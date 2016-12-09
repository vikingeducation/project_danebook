class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy

  accepts_nested_attributes_for :profile
  validates :password, 
            :length => { :in => 8..30 }, 
            :allow_nil => true
  validates :first_name,
            length: { in: 2..20 }
  validates :last_name,
            length: { in: 2..20 }

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
