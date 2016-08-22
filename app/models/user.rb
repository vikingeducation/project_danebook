class User < ApplicationRecord
  has_secure_password
  after_create :generate_token, :set_default_photos, :send_welcome_email
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :recieved_friendings, foreign_key: :friendee, class_name: 'Friending'
  has_many :frienders, through: :recieved_friendings, source: :friending_initiator

  has_many :initiated_friendings, foreign_key: :friender, class_name: 'Friending'
  has_many :friendees, through: :initiated_friendings, source: :friending_recipient
  belongs_to :cover_photo, class_name: 'Photo', foreign_key: :cover_photo_id, optional: true
  belongs_to :profile_photo, class_name: 'Photo', foreign_key: :profile_photo_id, optional: true

  accepts_nested_attributes_for :profile, update_only: true

  validates :password,
    :length => { :in => 6..24 },
    :allow_nil => true

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: /@/, message: 'email must contain an @ symbol'}

  def last_post_date
    posts.order(created_at: :desc).first.created_at.to_date if posts.any?
  end

  def newsfeed_posts(num)
    Post.where('user_id IN (?)', newsfeed_friends.pluck(:id)).order(created_at: :desc)
    # newsfeed_friends.select(:posts).joins('JOIN posts ON users.id=posts.user_id').order(:created_at).limit(num)
  end

  def newsfeed_friends
      User.joins('JOIN friendings ON users.id=friender').where('friender=?', self.id).or(User.joins('JOIN friendings ON users.id=friender').where('friendee=?', self.id)).uniq
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver!
  end

  def self.suggested_friends_email(id)
    user = User.find(id)
    UserMailer.suggested_friends(user).deliver!
  end

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

  def set_default_photos
    self.cover_photo = Photo.first
    self.profile_photo = Photo.second
    save!
  end

  def self.with_first_names_like(search)
    search = sanitize_sql_like(search.downcase)
    search = '%' + search
    search += '%'
    User.joins('JOIN profiles ON users.id=user_id').where("first_name ILIKE ?", search)
  end

  def self.with_last_names_like(search)
    search = sanitize_sql_like(search.downcase)
    search = '%' + search
    search += '%'
    User.joins('JOIN profiles ON users.id=user_id').where("last_name ILIKE ?", search)
  end

  def self.with_full_names_like(search)
    search = sanitize_sql_like(search.downcase)
    search += '.*'
    search = '.*' + search
    User.joins('JOIN profiles ON users.id=user_id').where("CONCAT(first_name, ' ', last_name) ~* ?", search)
  end

  def self.with_names_like(search)
    with_first_names_like(search).or(with_last_names_like(search)).or(with_full_names_like(search))
  end
end
