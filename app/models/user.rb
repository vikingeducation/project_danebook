class User < ApplicationRecord
  has_secure_password

  has_many :photos, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :authored_posts, class_name: :Post

  has_many :comments
  has_many :authored_comments, through: :comments, source: :commentable, source_type: :Comment

  has_many :likes
  has_many :posts_they_like, through: :likes, source: :likeable, source_type: :Post
  has_many :photos_they_like, through: :likes, source: :likeable, source_type: :Photo
  has_many :comments_they_like, through: :likes, source: :likeable, source_type: :Comment

  # Friendings initiator
  has_many :initiated_friendings,
           :class_name => "Friending",
           :foreign_key => :initiator_id
  has_many :friended_users,
           :through => :initiated_friendings,
           :source => :friend_recipient

  # Friendings recipient
  has_many :received_friendings,
           :class_name => "Friending",
           :foreign_key => :recipient_id
  has_many :users_friended_by,
           :through => :received_friendings,
           :source => :friend_initiator


  validates :name, presence: true

  validates :email,
            presence: true,
            :uniqueness => true,
            :format => { :with => /@/ }

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  def display_name
    name.blank? ? email : name
  end

  def friends
    # currently, friend requests do not require approval
    (friended_users + users_friended_by).uniq
  end

  def has_friends?
    friends.any?
  end

  def post_count
    authored_posts.count
  end

end
