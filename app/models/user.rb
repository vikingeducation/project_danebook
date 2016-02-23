class User < ActiveRecord::Base

  before_create :generate_token
  after_create :create_profile

  has_one :profile, dependent: :destroy
  has_many :posts
  has_many :comments

  # initiator side:
  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  # receiving side:
  has_many :received_friendings, foreign_key: :friend_id, class_name: "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator


  has_secure_password



  validates :password, length: { :in => 8..24 }, allow_nil: true
  validates :first_name, :last_name, length: { :in => 1..24 }, presence: true
  validates :email, length: { :in => 1..24 }, presence: true, uniqueness: true


  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    # invalidate old
    self.auth_token = nil
    # create new
    generate_token
    save!
  end


  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver!
  end



end
