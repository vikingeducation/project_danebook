class User < ApplicationRecord
  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile, reject_if: :all_blank

  before_create :generate_token

  has_secure_password


  validates_format_of :email, with: /\A[^@]+@[^@]+\.[^@]+\Z/, allow_nil: true
  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}\Z/, allow_nil: true

  def regenerate_auth_token
    destroy_token
    generate_token
    save!
  end

  def destroy_token
    self.token = nil
  end

private

    def generate_token
      begin
        self[:token] = SecureRandom.urlsafe_base64
      end while User.exists?(:token => self[:token])
    end

end
