class User < ActiveRecord::Base
  has_secure_password

  has_one :profile
  has_many :posts, foreign_key: :author_id

  has_many :likings

  has_many :liked_posts, through: :likings,
                         source: :post

  accepts_nested_attributes_for :profile

  validates :password,
            :length => { in: 8..24 },
            :allow_nil => true

  validates :email, format: { with: /@/, message: "Please enter a valid email" }

  before_create :generate_token

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
    self.profile.first_name + " " + self.profile.last_name
  end

  def birthday
    p = self.profile
    p.birth_month + " " + p.birth_day  + ", " + p.birth_year
  end
end
