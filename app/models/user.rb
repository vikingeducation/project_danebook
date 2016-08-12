class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :password, 
            :length => { :in => 8..24 }, 
            :allow_nil => true

  validates :email,
            :presence => true,
            :uniqueness => true

  has_one :profile
  has_many :posts
  has_many :likes
  has_many :comments

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

  def find_like(post)
    likes.where("post_id = ?", post.id)
  end

  def like_exist?(post)
    !find_like(post).empty?
  end

end
