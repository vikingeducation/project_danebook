class User < ActiveRecord::Base
  include Dateable
  include Searchable

  searchable_scope ->(q){where("first_name || ' ' || last_name LIKE ?", "%#{q}%")}

  has_one :profile, :dependent => :destroy
  belongs_to :profile_photo, :foreign_key => :profile_photo_id, :class_name => 'Photo'
  belongs_to :cover_photo, :foreign_key => :cover_photo_id, :class_name => 'Photo'
  belongs_to :gender
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy
  has_many :photos, :dependent => :destroy

  has_many  :requested_friendships,
            :class_name => 'Friendship',
            :foreign_key => :initiator_id

  has_many  :friendship_accepters,
            :through => :requested_friendships,
            :source => :approver

  has_many  :accepted_friendships,
            :class_name => 'Friendship',
            :foreign_key => :approver_id

  has_many  :friendship_requesters,
            :through => :accepted_friendships,
            :source => :initiator

  has_many  :sent_friend_requests,
            :class_name => 'FriendRequest',
            :foreign_key => :initiator_id

  has_many  :friend_request_receivers,
            :through => :sent_friend_requests,
            :source => :approver

  has_many  :received_friend_requests,
            :class_name => 'FriendRequest',
            :foreign_key => :approver_id

  has_many  :friend_request_senders,
            :through => :received_friend_requests,
            :source => :initiator

  has_secure_password

  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => /@/

  validates :password,
            :length => {:in => 8..32},
            :format => {:without => /\s/},
            :allow_nil => true

  validates :first_name,
            :presence => true,
            :format => {:with => /\A[a-zA-Z]+\z/}

  validates :last_name,
            :presence => true,
            :format => {:with => /\A[a-zA-Z]+\z/}

  validates :birthday,
            :presence => true

  validates :gender,
            :presence => true

  validate :cover_photo_belongs_to_user, :on => :update, :if => ->{cover_photo_id.present?}
  validate :profile_photo_belongs_to_user, :on => :update, :if => ->{profile_photo_id.present?}

  accepts_nested_attributes_for :profile

  before_create :create_profile
  after_create :create_auth_token

  DEFAULT_PROFILE_PHOTO_URL = '/assets/images/user_silhouette_generic.gif.png'
  DEFAULT_COVER_PHOTO_URL = 'http://placehold.it/768x512'

  def profile_photo_url(style=nil)
    if profile_photo
      style ? profile_photo.file.url(style) : profile_photo.file.url
    else
      DEFAULT_PROFILE_PHOTO_URL
    end
  end

  def cover_photo_url(style=nil)
    if cover_photo
      style ? cover_photo.file.url(style) : cover_photo.file.url
    else
      DEFAULT_COVER_PHOTO_URL
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def create_auth_token
    update!(:auth_token => generate_auth_token)
    auth_token
  end

  def friends
    User.where(
      'id IN (?) OR id IN (?)',
      friendship_requesters.pluck(:id),
      friendship_accepters.pluck(:id)
    )
  end

  def friendships
    Friendship.find_by_user(self)
  end

  def friend_requests
    FriendRequest.find_by_user(self)
  end

  def friendship_with(user)
    friendships_with_user = friendships.find_by_user(user)
    friend_requests_with_user = friend_requests.find_by_user(user)
    if friendships_with_user.present?
      friendships_with_user.first
    elsif friend_requests_with_user.present?
      friend_requests_with_user.first
    else
      FriendRequest.new(
        :initiator_id => id,
        :approver_id => user.id
      )
    end
  end

  def friend?(user)
    Friendship.find_by_users(self, user).present?
  end


  private
  def generate_auth_token
    str = SecureRandom.uuid + email
    SecureRandom.urlsafe_base64 + Base64.urlsafe_encode64(str)
  end

  def cover_photo_belongs_to_user
    photo_belongs_to_user(cover_photo_id)
  end

  def profile_photo_belongs_to_user
    photo_belongs_to_user(profile_photo_id)
  end

  def photo_belongs_to_user(photo)
    photo_id = photo.is_a?(Photo) ? photo.id : photo
    unless photos.where(:id => photo_id).present?
      reload
      errors.add(:base, 'Photo must belong to user')
    end
  end
end


