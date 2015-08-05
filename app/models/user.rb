class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token

  # has_many :posts, :through => :user_postings
  # has_many :user_postings
  has_many :posts
  has_one :profile
  has_one :like
  has_many :comments
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password, presence: true, length: {in: 7..24}, confirmation: true, :on=> [:new]

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
    self.first_name + " " + self.last_name
  end


end
