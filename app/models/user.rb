class User < ApplicationRecord

  has_secure_password

  # creates profile upon sign up
  has_one :profile, inverse_of: :user, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true, reject_if: :all_blank

  # associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  # self-referencing / friending functionality
  has_many :frienders, through: :friender_friendships, source: :friender, dependent: :destroy
  has_many :friender_friendships, foreign_key: :friendee_id, class_name: 'Friendship', dependent: :destroy
  has_many :friendees, through: :friendee_friendships, source: :friendee , dependent: :destroy
  has_many :friendee_friendships, foreign_key: :friender_id, class_name: 'Friendship', dependent: :destroy

  # Validations
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

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver!
  end


end
