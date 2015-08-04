class User < ActiveRecord::Base
  before_create :generate_token
  after_create :generate_empty_profile

  has_secure_password

  validates :email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password,
             presence: true,
             length: {in: 8..24},
             confirmation: true,
             allow_nil: true

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :written_posts, class_name: "Post", foreign_key: :user_id

  has_many :comments
  has_many :things_commented_on, through: :comments

  has_many :likes
  has_many :liked_things, through: :likes

  def full_name
    self.first_name + " " + self.last_name
  end

  def birthday
    self.dob.strftime("%B %d, %Y")
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

  def generate_empty_profile
    self.profile = Profile.new
  end

end
