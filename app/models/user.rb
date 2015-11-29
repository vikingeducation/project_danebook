class User < ActiveRecord::Base
  include Searchable

  searchable_scope ->(q){where("first_name || ' ' || last_name LIKE ?", "%#{q}%")}

  has_one :profile, :dependent => :destroy
  belongs_to :gender
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :likes, :dependent => :destroy

  has_many  :requested_friendships,
            :class_name => 'Friendship',
            :foreign_key => :initiator_id

  has_many  :friendship_accepters,
            :through => :requested_friendships,
            :foreign_key => :approver_id

  has_many  :accepted_friendships,
            :class_name => 'Friendship',
            :foreign_key => :approver_id

  has_many  :friendship_requesters,
            :through => :accepted_friendships,
            :foreign_key => :initiator_id

  has_many  :sent_friend_requests,
            :class_name => 'FriendRequest',
            :foreign_key => :initiator_id

  has_many  :friend_request_receivers,
            :through => :sent_friend_requests,
            :foreign_key => :approver_id

  has_many  :received_friend_requests,
            :class_name => 'FriendRequest',
            :foreign_key => :approver_id

  has_many  :friend_request_senders,
            :through => :received_friend_requests,
            :foreign_key => :initiator_id

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

  accepts_nested_attributes_for :profile

  before_create :create_profile
  after_create :create_auth_token

  def name
    "#{first_name} #{last_name}"
  end

  def create_auth_token
    update!(:auth_token => generate_auth_token)
    auth_token
  end

  def friends
    Friendship.find_by_user(self)
  end

  def friend_requests
    FriendRequest.find_by_user(self)
  end


  private
  def generate_auth_token
    str = SecureRandom.uuid + email
    SecureRandom.urlsafe_base64 + Base64.urlsafe_encode64(str)
  end
end


