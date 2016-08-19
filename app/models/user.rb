class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password
  validates :email,
              uniqueness: {case_sensitive: false},
              presence: true,
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :initiated_friendings, class_name: "Friending",
                                  foreign_key: :friender_id
  has_many :friended_users, through: :initiated_friendings,
                            source: :friend_recipient,
                            dependent: :destroy
  has_many :received_friendings, foreign_key: :friend_id,
                                 class_name: "Friending"
  has_many :users_friended_by, through: :received_friendings,
                               source: :friend_initiator,
                               dependent: :destroy

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  def to_s
    profile.first_name + " " + profile.last_name
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def make_friend(friend)
    friended_users << friend
    users_friended_by << friend
  end

  def friends?(friend)
    friends.include?(friend)
  end

  def unfriend(friend)
    friended_users.delete(friend)
    users_friended_by.delete(friend)
  end

  def friends
    friended_users
  end

  def recent_friends
    friended_users.limit(4)
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end
end
