class User < ApplicationRecord

  has_secure_password
  has_one :profile, inverse_of: :user

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :password, length: {in: 3..20}, allow_nil: true
  validates :email, presence: true, uniqueness: true

  before_create :generate_token

  # generate token for persisted login
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

  # regenerate tokens whenever needed
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end


private



end
