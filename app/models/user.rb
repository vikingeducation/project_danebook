class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, foreign_key: :user_id
  has_many :comments, foreign_key: :user_id
  #selfjoin woo!
  has_many :initiated_friendships,  foreign_key: :friendee_id, class_name: "Friend"
  has_many :users_friended_by, through: :initiated_friendships,
                                source: :friender

 has_many :recived_friendships,  foreign_key: :friender_id, class_name: "Friend"
 has_many :friended_users, through: :recived_friendships,
                                source: :friendee

 has_many :photos, dependent: :destroy



  def cover_photo
    self.profile.cover_photo
  end

  def profile_photo 
    self.profile.profile_photo
  end
                              



  accepts_nested_attributes_for :profile

  validates :password, 
            length: { in: 8..256 }, 
            allow_nil: true

  validates :email,
            uniqueness: true

  validates :first_name, presence: true
  validates :last_name, presence: true

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self[:auth_token])
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

  def cover_photo
    profile.cover_photo
  end

  def cover_photo
    profile.cover_photo
  end

  def self.search(query)
    if query
      # Parameterize that user input!!!
      a = where("first_name LIKE ?", "%#{query}%")
      b = where("last_name LIKE ?", "%#{query}%")
      a + b
    else
      # If no search term provided, this returns
      # a relation so we can chain this
      where("")
    end
  end
end
