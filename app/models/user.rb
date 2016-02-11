class User < ActiveRecord::Base

  before_create :generate_token
  has_secure_password


  validates :password, length: { :in => 8..24 }, allow_nil: true
  validates :first_name, :last_name, length: { :in => 1..24 }, presence: true
  validates :email, length: { :in => 1..24 }, presence: true, uniqueness: true


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    # invalidate old
    self.auth_token = nil
    # create new
    generate_token
    save!
  end






end
