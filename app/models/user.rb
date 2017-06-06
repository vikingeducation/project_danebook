class User < ApplicationRecord
  before_create :generate_token

  # -----------------------------------------------------------------
  # Associations
  # -----------------------------------------------------------------

  has_one :profile, inverse_of: :user

  # -----------------------------------------------------------------
  # Validations
  # -----------------------------------------------------------------

  validates :password,
            ## http://quickleft.com/blog/rails-tip-validating-users-with-has_secure_password
            length: {minimum: 8},
            allow_nil: true

  # -----------------------------------------------------------------
  # Misc
  # -----------------------------------------------------------------

  has_secure_password
  accepts_nested_attributes_for :profile,
                                reject_if: :all_blank,
                                allow_destroy: :true

  # -----------------------------------------------------------------
  # Methods
  # -----------------------------------------------------------------

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
