class User < ApplicationRecord

  validates :password, confirmation: true, length: {in: 3..20}, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  before_create :generate_token


private

  # generate token for persisted login
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exsists?(auth_token: self[:auth_token])
  end

  # regenerate tokens whenever needed 
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end


end
