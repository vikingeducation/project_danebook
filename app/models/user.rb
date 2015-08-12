class User < ActiveRecord::Base
  before_create :generate_token
  after_create :generate_empty_profile, :send_welcome_email

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password,
             presence: true,
             length: {in: 8..24},
             confirmation: true,
             allow_nil: true

  validates :password_confirmation, presence: true, on: :create

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :written_posts, -> { order('created_at DESC') } , class_name: "Post", foreign_key: :user_id

  has_many :comments, dependent: :destroy
  has_many :posts_commented_on, through: :comments, source: :commentable, source_type: 'Post'
  has_many :comments_commented_on, through: :comments, source: :commentable, source_type: 'Comment'

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likable, source_type: 'Post'
  has_many :liked_comments, through: :likes, source: :likable, source_type: 'Comment'

  has_many :friendings, dependent: :destroy
  has_many :friends, through: :friendings

  has_many :uploaded_photos, class_name: "Photo", foreign_key: :user_id

  belongs_to :cover_photo, class_name: "Photo"
  belongs_to :profile_photo, class_name: "Photo"

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def self.search(term)
    User.where("first_name ILIKE ? OR last_name ILIKE ?", '%' + term.to_s + '%', '%' + term.to_s + '%')
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def birthday
    self.dob.strftime("%B %d, %Y")
  end

  def likes? (likable_thing)
    Like.where(user: self, likable_id: likable_thing.id, likable_type: likable_thing.class).any?
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

  private

    def generate_empty_profile
      self.profile = Profile.new
    end

end
