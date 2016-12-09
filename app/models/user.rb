class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_one :profile
  has_many :posts
  has_many :likes, foreign_key: :user_id

  accepts_nested_attributes_for :profile

  validates :password, 
            :length => { :in => 8..256 }, 
            :allow_nil => true

  validates :email,
            uniqueness: true

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
