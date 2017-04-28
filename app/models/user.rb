class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_likes, dependent: :destroy
  has_many :photos

  #  self join for friendship
  has_many :initiated_friendships, class_name: 'Friendship', foreign_key: :friender_id
  has_many :received_friendships, class_name: 'Friendship', foreign_key: :friendee_id
  has_many :friendees, through: :initiated_friendships, source: :friend_recipient
  has_many :frienders, through: :received_friendships, source: :friend_initiator

  validates :email, presence: true, uniqueness: true, length: { minimum: 6}, on: [:create]
  validates :password, :password_confirmation, presence: true, length: {minimum: 12 }, on: :create
  accepts_nested_attributes_for :profile
  validates_associated :profile

  def first_name
    profile.first_name
  end

  def friendship_status(user)
    return nil unless user
    # if rejected is true, return rejected
    return 'rejected' if self.request_rejected?(user)
    # if rejected is nil, return pending
    return 'pending' if self.request_pending?(user)
    return 'friends' if self.request_accepted?(user)

  end



  def is_friends_with?(user)
    return false unless user
    ! Friendship.where('friender_id = ? AND friendee_id = ?', self.id, user.id).blank?
  end

  def is_friend_of?(user)
    return false unless user
    ! Friendship.where('friender_id = ? AND friendee_id = ?', user.id, self.id).blank?
  end

  def full_name
    profile.first_name + ' ' + profile.last_name
  end

  def birthday
    self.profile.birthday
  end

  protected

  def request_accepted?(user)
    return false unless user
    Friendship.where('friender_id = ? AND friendee_id = ? AND rejected IS ?', user.id, self.id, false).present?
  end

  def request_pending?(user)
    return false unless user
    Friendship.where('friender_id = ? AND friendee_id = ? AND rejected IS ?', user.id, self.id, nil).present?
  end

  def request_rejected?(user)
    return false unless user
    Friendship.where('friender_id = ? AND friendee_id = ? AND rejected = ?', user.id, self.id, true).present?
  end



end
