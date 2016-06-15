class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token 
  before_create :create_activation_digest

  include PgSearch

  VALID_EMAIL_REGEX = /\A[\w\d\.\_]{4,254}@\w{,6}\.\w{3}\z/

  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_secure_password

  #Token and digest creation for security.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #Remembering and forgetting.
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  #Generalized method for checking token against digest in DB.
  def authenticated?(attribute,token)
    digest = self.send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #Paginating search results, if any.
  def User.search(search, page)
    if search
      where('last_name LIKE ?', "%#{search.capitalize}%").paginate(page: page, per_page: 10)
    else
      scoped
    end
  end

  #Send activation email.
  def send_activation_email
    UserMailer.activation(self).deliver_now
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
