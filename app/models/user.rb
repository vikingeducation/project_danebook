class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  after_create :queue_welcome_email

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_likes, through: :comments, source: :likes, dependent: :destroy
  has_many :photos

  #  self join for friendship
  has_many :initiated_friendships, class_name: 'Friendship', foreign_key: :friender_id, dependent: :destroy
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :friendee_id, dependent: :destroy
  has_many :friendees, through: :initiated_friendships, source: :friend_recipient
  has_many :frienders, through: :received_friendships, source: :friend_initiator


  validates :email, presence: true, uniqueness: true, length: { minimum: 6}, on: [:create]
  validates :password, :password_confirmation, presence: true, length: {minimum: 12 }, on: :create
  accepts_nested_attributes_for :profile
  validates_associated :profile

  def cover(size=:medium)
    self.profile.cover.url(size)
  end

  def avatar(size=:medium)
    self.profile.avatar.url(size)
  end

  def self.recommended_friends(user)
    User.limit(5).order('random()').where('id != ?', user.id)
  end


  def first_name
    profile.first_name
  end

  def friendship_status(user)
    return nil unless user
    friendship = user.initiated_friendships.find_by(friendee_id: self.id)
    return friendship.rejected if friendship.present?
    return 'received' if user.friend_requests.present?
    return 'create'
  end

  def friend_requests
    self.frienders.where('friendee_id = ? AND rejected IS ?', self.id, nil)
  end

  def full_name
    profile.first_name + ' ' + profile.last_name
  end

  def birthday
    self.profile.birthday
  end

  private

  def queue_welcome_email
    UserMailer.welcome(self).deliver_later
  end



end
