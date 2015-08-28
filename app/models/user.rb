class User < ActiveRecord::Base

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, :foreign_key => :poster_id, :dependent => :destroy

  has_many :likes, :foreign_key => :liker_id, :dependent => :destroy

  has_many :comments, :foreign_key => :author_id, :dependent => :destroy

  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => 'Friending', :dependent => :destroy
  has_many :friended_users, :through => :initiated_friendings, :source => :friend_recipient

  has_many :received_friendings, :foreign_key => :friend_id, :class_name => 'Friending', :dependent => :destroy
  has_many :users_friended_by, :through => :received_friendings, :source => :friend_initiator

  has_many :photos, :foreign_key => :poster_id, :dependent => :destroy
  belongs_to :profile_photo, :class_name => 'Photo'
  belongs_to :cover_photo, :class_name => 'Photo'


  has_secure_password

  validates :email, :uniqueness => true, :format => { :with => /.+@.+\.[a-z]{2,}/, :message => "format is invalid." }
  validates :password,
            :length => { :in => 6..24 },
            :allow_nil => true
  validates_confirmation_of :password


  before_create :generate_token



  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end


  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end


  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver!
  end


  def self.get_recently_active_friends(newsfeed_posts)
    User.where('id IN (?)', newsfeed_posts.pluck(:poster_id).uniq)
  end


end
