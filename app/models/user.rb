class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password

  has_one :profile, dependent: :destroy
  has_many :posts, :foreign_key => :author_id, dependent: :destroy
  has_many :likes, :foreign_key => :liker_id, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 }
  validates :gender, :inclusion => ["Female",
                                    "Male",
                                    "Other"],
                     :allow_blank => true,
                     :allow_nil => true

  def name
    "#{first_name} #{last_name}"
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
