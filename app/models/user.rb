class User < ApplicationRecord
  after_create :send_delayed_welcome_email

  has_attached_file :avatar, styles: { medium: ["100x100#"] }, default_url: Rails.root.join("app/assets/images/style/missing.jpeg")
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_attached_file :cover_image, styles: { medium: ["1000x300#"] }, default_url: Rails.root.join("app/assets/images/cover/cover.jpg")
  validates_attachment_content_type :cover_image, content_type: /\Aimage\/.*\z/

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  # When acting as the initiator of the friending
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable

  validates :username, length: { within: 4..15 },
                       uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates_uniqueness_of :email, case_sensitive: false

  def has_posts?
    !self.posts.empty?
  end

  def already_liked?(staff)
    self.likes.find_by(likeable: staff) ? true : false
  end

  def self.search_user(username)
    self.where("lower(username) LIKE '%#{username}%'")
  end

  def already_friended?(user)
    self.friended_users.find_by_id(user) ? true : false
  end

  def has_friends?
    self.friended_users.empty? ? false : true
  end

  def reversed_posts
    self.posts.order("created_at").reverse_order
  end

  def user_and_friends_posts
    Post.includes(:author, :likes => :user, :comments => [:user, :likes => :user]).where(user_id: (self.friended_users.pluck(:id) << self.id)).order("created_at").reverse_order
    # self.posts.order(:created_at).reverse_order
  end

  def recent_friend_posts
    Post.where(author: self.friended_users).where("created_at >= ?", DateTime.now - 7)
    # fail
  end


  private

  def send_delayed_welcome_email
    User.delay.send_welcome_email(self)
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end
end
