class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :photos
  belongs_to :profile_pic, class_name: "Photo"
  belongs_to :cover_pic, class_name: "Photo"
  has_many :comments, dependent: :nullify

  has_many :postings, dependent: :destroy
  has_many :text_posts, through: :postings, source: :postable, source_type: "Post"
  has_many :photo_posts, through: :postings, source: :postable, source_type: "Photo"

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :likeable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likeable, source_type: "Comments"

  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  has_many :received_friendings, :foreign_key => :friend_id, :class_name => "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :posts
  accepts_nested_attributes_for :photos

  before_create :generate_token
  after_create :create_profile
  after_create { send_welcome_email(self.id) }

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  validates :first_name, :last_name,
            :presence => true,
            :length => { :minimum => 1 }

  validates :birth_date,
           :presence => true

  validates_date :birth_date, on_or_after: lambda { 125.years.ago }

  validates_date :birth_date, :on_or_before => lambda { Date.current }


  validates :email, presence: true, uniqueness: {case_sensitive: false},
            length: { in: 4..50}

  validates_format_of :email, :with => /@/


  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def recent_user_posts
    self.posts.order(:updated_at => :desc)
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

  def photo_count
    self.photo_posts.count
  end

  private

    def send_welcome_email(id)
      user = User.find_by_id(id)
      UserMailer.welcome(user).deliver!
    end
    # handle_asynchronously :send_welcome_email

end
