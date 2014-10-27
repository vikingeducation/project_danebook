class User < ActiveRecord::Base
  before_create :generate_token

  belongs_to :location
  belongs_to :school

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :school;
  accepts_nested_attributes_for :location;




  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, length: {maximum: 64}
  validates :last_name, presence: true, length: {maximum: 64 }
  validates :email, presence: true, length: {minimum: 1, maximum:64},
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 6, maximum: 16}, allow_nil: true

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Make a convenience method for regenerating the token 
  # when we need it
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
