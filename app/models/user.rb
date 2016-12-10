class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :authored_posts, foreign_key: :author_id, class_name: "Post"
  has_many :liked_posts, foreign_key: :liker_id, class_name: "Post"

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :authored_posts
  validates :password, 
            :length => { :in => 8..30 }, 
            :allow_nil => true
  validates :first_name,
            length: { in: 2..20 }
  validates :last_name,
            length: { in: 2..20 }

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
