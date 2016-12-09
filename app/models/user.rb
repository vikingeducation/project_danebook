class User < ApplicationRecord
  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile, reject_if: :all_blank

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  before_save :format_input

  has_secure_password

  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[^@]+@[^@]+\.[^@]+\Z/, allow_nil: true
  validates_format_of :password, with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{12,}\Z/, allow_nil: true

  def regenerate_auth_token
    destroy_token
    generate_token
    save!
  end

  def destroy_token
    self.token = nil
  end

private

    def format_input
      email.downcase! if email
    end

    def generate_token
      begin
        self[:token] = SecureRandom.urlsafe_base64
      end while User.exists?(token: self[:token])
    end

end
