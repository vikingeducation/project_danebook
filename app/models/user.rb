class User < ActiveRecord::Base

  # ----------------------- Associations --------------------

  has_one :profile, dependent: :destroy

  has_many :posts, -> { order('created_at DESC') },
            dependent: :destroy,
            foreign_key: :author_id,
            class_name: "Post"

  has_many :posts_received, -> { order('created_at DESC') },
            dependent: :destroy,
            foreign_key: :recipient_user_id,
            class_name: "Post"

  has_many  :comments,
            dependent: :destroy,
            foreign_key: :author_id

  has_many  :likes,
            dependent: :destroy

  has_secure_password

  # When acting as the initiator of the friending
  has_many :requests,             foreign_key: :friender_id,
                                  class_name: "Friending",
                                  dependent: :destroy

  has_many :friends,              through: :requests,
                                  source: :target

  # When acting as the recipient of the friending
  has_many :received_friendings,  foreign_key: :friend_id,
                                  class_name: "Friending",
                                  dependent: :destroy

  has_many :users_friended_by,    through: :received_friendings,
                                  source: :friender

  has_many :photos, -> { order('created_at DESC') },
            dependent: :destroy

  belongs_to :profile_pic, foreign_key: :profile_pic,
                            class_name: "Photo"

  belongs_to :cover_photo, foreign_key: :cover_photo,
                            class_name: "Photo"


  # ----------------------- Validations --------------------

  validates :first_name, :last_name,
            :length => { :in => 1..30 },
            presence: true

  validates :email,
            :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i },
            length: { in: 6..30 },
            presence: true,
            uniqueness: true

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  # ----------------------- Callbacks --------------------

  before_create :generate_token

  # Creates a user profile after user creation
  after_create :build_profile

  after_create :delay_welcome_email


  # ----------------------- Class Methods --------------------


  def self.filter_results(query)
    words = query ? query.split(/\s/) : ""
    if words.size > 1
      where("first_name ILIKE ? AND last_name ILIKE ?", "%#{words[0]}%", "%#{words[1]}%")
    else
      where("first_name ILIKE ? OR last_name ILIKE ?", "%#{query}%", "%#{query}%")
    end.
      includes(:profile, :profile_pic).
      order("first_name ASC, last_name ASC")
  end


  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

  # ----------------------- Instance Methods --------------------

  def name
    "#{first_name} #{last_name}"
  end

  def friended_by?(user)
    Friending.find_by({friend_id: self.id, friender_id: user.id })
  end

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token]) # No repeat tokens among users. Reflects database unique constraint
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def build_profile
    Profile.new(user_id: self.id).save
  end

  def delay_welcome_email
    User.delay.send_welcome_email(self.id)
  end

end
