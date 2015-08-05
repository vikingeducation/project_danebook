class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  before_create  :generate_token
  after_create :make_profile

  def make_profile
    self.build_profile.save
  end

  def generate_token
    begin 
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token]) 
  end

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end
end
