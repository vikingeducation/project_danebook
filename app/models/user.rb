class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :password, :length => { :in => 3..24 }, :allow_nil => true
  validates :first_name,
            :last_name, length: { :in => 1..12 }, presence: true
  validates :email, length: { :in => 1..24 }, presence: true, uniqueness: true

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
