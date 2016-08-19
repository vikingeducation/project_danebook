class User < ApplicationRecord
  has_secure_password
  before_create :generate_token
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recieved_friendings, foreign_key: :friendee, class_name: 'Friending'
  has_many :frienders, through: :recieved_friendings, source: :friending_initiator

  has_many :initiated_friendings, foreign_key: :friender, class_name: 'Friending'
  has_many :friendees, through: :initiated_friendings, source: :friending_recipient

  accepts_nested_attributes_for :profile, update_only: true

  validates :password,
    :length => { :in => 6..24 },
    :allow_nil => true

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /@/, message: 'email must contain an @ symbol'}



  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def name
    profile.name
  end

  def friend_with?(user)
    friendees.include?(user)
  end

  def friends
    friendees
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def errors?
    errors.full_messages.any?
  end

  def includes_at_sym(email)
    email.include?('@')
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
