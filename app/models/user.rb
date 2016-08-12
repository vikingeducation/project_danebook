class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  # has_many :feeds
  # has_many :posts, through: :feeds
  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :posts

  before_create :generate_token
  after_create :create_profile

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
  validates :first_name, :last_name,
            :presence => true,
            :length => { :minimum => 2 },
            :allow_nil => true
  validates :birth_date,
           :presence => true,
           :allow_nil => true

  def full_name
    first_name.capitalize + " " + last_name.capitalize
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
end
