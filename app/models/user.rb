class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :initiated_friendings, foreign_key: :friender_id, class_name: 'Friending'
  has_many :friendees, through: :initiated_friendings, source: :friendee

  has_many :received_friendings, foreign_key: :friendee_id, class_name: 'Friending'
  has_many :frienders, through: :received_friendings, source: :friender

  has_one :profile, inverse_of: :user, dependent: :destroy

  has_many :posts, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :liker_id, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :posts
  has_many :liked_comments, through: :likes, source: :comments

  accepts_nested_attributes_for :profile

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def friends
    frienders + friendees
  end

  def friends_sample(n = 5)
    friends[0..n]
  end

  def self.search(query)
    if query
      self.where("first_name ILIKE ?", "%#{query}%").or(self.where("last_name ILIKE ?", "%#{query}%"))
    else
      self.where("")
    end
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

  def self.welcome_email(id)
    UserMailer.welcome(find(id)).deliver
  end

            
end
