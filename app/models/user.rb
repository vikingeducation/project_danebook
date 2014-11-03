class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password

  has_one :profile, dependent: :destroy
  has_one :cover_photo, through: :profile

  has_many :posts, :foreign_key => :author_id, dependent: :destroy
  has_many :comments, :foreign_key => :author_id, dependent: :destroy
  has_many :likes, :foreign_key => :liker_id, dependent: :destroy
  has_many :photos, :foreign_key => :author_id, dependent: :destroy

  # friend mechanics
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator
  # end of friend mechanics

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 },
                       allow_nil: true
  validates :gender, :inclusion => ["Female",
                                    "Male",
                                    "Other"],
                     :allow_blank => true,
                     :allow_nil => true

  def name
    "#{first_name} #{last_name}"
  end

  def friends
    User.where(id: Friending.
         where(friend_id: self.id, friender_id: Friending.
         where(friender_id: self.id).
               pluck(:friend_id)).pluck(:friender_id))
  end

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

  def self.welcome_email(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver!
  end
end
