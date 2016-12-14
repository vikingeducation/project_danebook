class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_one :profile, inverse_of: :user

  has_many :posts
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :liker_id
  has_many :liked_posts, through: :likes, source: :posts
  has_many :liked_comments, through: :likes, source: :comments

  accepts_nested_attributes_for :profile

  def full_name
    self.first_name + ' ' + self.last_name
  end

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
