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

  def make_friends(friend)
    self.initiated_friendships.build(friendee_id: friend)
    self.received_friendships.build(friender_id: friend)
    self
  end


  def friendships(id)
    Friendship.where('(friender_id = ? AND friendee_id = ?) OR (friender_id = ? AND friendee_id = ?)', self.id, id, id, self.id)
  end

  def is_friends_with?(id)
    ! Friendship.where('(friender_id = ? AND friendee_id = ?) OR (friender_id = ? AND friendee_id = ?)', self.id, id, id, self.id).blank?
  end

  def full_name
    profile.first_name + ' ' + profile.last_name
  end

  def birthday
    self.profile.birthdate #.strftime('%B %e, %Y')
  end


end
