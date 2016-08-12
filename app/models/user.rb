class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest

  ## Scopes ##
  scope :everyone, -> (id) { where("users.id != #{id}") }
  # PG Search
  include PgSearch
  # Defining a pg search scope
  pg_search_scope :search_by_full_name,
                  associated_against:
                    { profile: ["first_name","last_name"] },
                  using: 
                    { tsearch: { dictionary: :english } }
                  


  ## Associations ##
  has_many :microposts, dependent: :destroy
  has_one :profile, dependent: :destroy

  # Friends.
  belongs_to :friendable, polymorphic: true
  has_many :friends, as: :friendable, class_name: 'User'

  accepts_nested_attributes_for :profile
  

  ## Validations ##
  VALID_EMAIL_REGEX = /\A[\w\d\.\_]{4,254}@\w{,6}\.\w{3}\z/

  validates_presence_of :email
  validates_uniqueness_of :email
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password


  # Token and digest creation for security.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Remembering and forgetting.
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  # Password reset.
  def make_reset_digest
    self.reset_token = User.new_token
    digest = User.digest(reset_token)
    update_attribute :reset_digest, digest
  end

  # Generalized method for checking token against digest in DB.
  def authenticated?(attribute,token)
    digest = self.send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Paginating search results, if any.
  # We want an array for this, so we don't use a scope.
  def User.search(search, page, user)
    case search
    when '', 'Search for users' 
      everyone(user.id).joins(:profile).where("profiles.user_id = users.id").order("profiles.last_name ASC").paginate(page: page, per_page: 10)
    else
      # Calling the pg search scope defined in the Profile model.
      User.search_by_full_name(search).paginate(page: page, per_page: 10)
    end
  end

  # Send activation email.
  def send_activation_email
    UserMailer.activation(self).deliver_now
  end

  # Send password reset email.
  def send_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def first_name
    @first_name ||= self.profile.first_name if self.profile
  end

  def last_name
    @last_name ||= self.profile.last_name if self.profile
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def friend?(user)
    self.friendable_id == user.id
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
