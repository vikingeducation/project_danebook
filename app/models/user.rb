class User < ActiveRecord::Base
  has_secure_password

  # # has paperclip profile pic
  # has_attached_file :profile_picture, :styles => { :medium => "300x300", :thumb => "100x100" }
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # # has paperclip cover photo
  # has_attached_file :cover_photo


  # ASSOCIATIONS

  has_many :likes
  
  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile

  has_many :posts, foreign_key: :author_id
  has_many :comments
  accepts_nested_attributes_for :comments

  # for friending
  has_many :initiated_friendships, class_name: "Friendship", foreign_key: :friender_id
  has_many :friended_users, through: :initiated_friendships, source: :friend_recipient

  # for being friended
  has_many :received_friendships, class_name: "Friendship", foreign_key: :friended_id
  has_many :users_friended_by, through: :received_friendships, source: :friend_initiator

  has_many :photos

  # cover and profile picture associations
  belongs_to :cover_photo, class_name: "Photo", foreign_key: :cover_photo_id
  belongs_to :profile_picture, class_name: "Photo", foreign_key: :profile_picture_id

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, 
                       :confirmation => true,
                       :length => {in: 8..24},
                       :allow_nil => true,
                       :format => {:without => /\s/ }
  validates :gender, :presence => true



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

  def name
    self.first_name + " " + self.last_name
  end

  def self.send_welcome_email(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver
  end

  # distinguish post author from timeline
  # post author is currently signed-in user
  # post recipient is whoever is currently 

end
