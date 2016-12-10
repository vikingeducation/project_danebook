class User < ApplicationRecord
  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :birthday, presence: true
  validates :gender_cd, presence: true
  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  has_one :profile
  has_many :posts
  has_many :photos, dependent: :destroy
  has_many :authored_comments, class_name: "Comment", foreign_key: :user_id, dependent: :destroy
  has_many :initiated_likes, class_name: "Like", foreign_key: :user_id, dependent: :destroy

  # When acting as the initiator of the friendship
  has_many :initiated_friendships, :foreign_key => :initiator,
                                   :class_name => "Friendship"
  has_many :initiated_friends, :through => :initiated_friendships,
                                :source => :friend_recipient

  # When acting as the recipient of the friendship
  has_many :received_friendships, :foreign_key => :recipient,
                                  :class_name => "Friendship"
  has_many :recieved_friends, :through => :received_friendships,
                              :source => :friend_initiator
  has_one :profile_photo, class_name: "Photo", foreign_key: :profile_user_id
  has_one :cover_photo, class_name: "Photo", foreign_key: :cover_user_id

  include PgSearch
  pg_search_scope :search,
                  :against => [:first_name, :last_name],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  def name
    "#{first_name} #{last_name}"
  end

  def name=(new_name)
    self.first_name = new_name.split.first
    self.last_name = new_name.split.last
  end

  def friends_with?(other_user)
    self.initiated_friends.include?(other_user)
  end

  def friends
    initiated_friends.where(id: recieved_friends.pluck(:id))
    # self.initiated_friends & self.recieved_friends
  end
  private
  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

  def self.send_comment_email(id)
    user = User.find(id)
    UserMailer.comment(user).deliver
  end
end
