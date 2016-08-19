class User < ApplicationRecord
  belongs_to :profile_photo, class_name: "Photo", optional: true
  belongs_to :cover_photo, class_name: "Photo", optional: true

  has_many :posts, :through => :activities, :source => :postable, :source_type => 'Post'
  has_many :photos, :through => :activities, :source => :postable, :source_type => 'Photo'
  has_many :comments_made, :through => :activities, :source => :postable, :source_type => 'Comment'
  has_many :activities, foreign_key: :author_id, dependent: :destroy
  has_many :liked_things, class_name: "Liking"

  has_many :initiated_friendings, foreign_key: :initiator_id, class_name: "Friending"
  has_many :followees, through: :initiated_friendings, source: :reciever

  has_many :recieved_friendings, foreign_key: :reciever_id, class_name: "Friending"
  has_many :followers, through: :recieved_friendings, source: :initiator

  before_create :generate_token

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
  validates :email, presence: true,
            uniqueness: { case_sensitive: false }, if: :email
  validates :first_name, presence: true, :length => { :in => 1..24 },
            if: :first_name
  validates :last_name, presence: true, :length => { :in => 1..24 },
            if: :last_name
  validates :gender, presence: true,
            if: :gender
  validates :birthday, presence: true,
            if: :birthday

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

  def fullname
    "#{first_name} #{last_name}"
  end

  def get_wall_activities
    activities.where.not("postable_type = ? OR postable_type = ?", "Comment", "Photo").order(id: :desc)
  end

  def day
    val = self.birthday.strftime("%-d") if self.birthday
    val.to_s
  end

  def month
    val = self.birthday.strftime("%-m") if self.birthday
    val.to_s
  end

  def year
    val = self.birthday.strftime("%Y") if self.birthday
    val.to_s
  end

  def current_friend?(user_id)
    followee_ids.include? user_id.to_i
  end

  def this_friend(user_id)
    initiated_friendings.find_by_reciever_id(user_id)
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver!
  end

  def self.send_alert_email(id)
    user = User.find(id)
    UserMailer.comment_alert(user).deliver!
  end

end
