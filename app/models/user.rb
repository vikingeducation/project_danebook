class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token

  has_many :posts
  has_one :profile, inverse_of: :user

  has_one :liked_post, through: :posts,
          source: :likes, foreign_key: :author_id

  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  accepts_nested_attributes_for :profile

  validates :password,
            :length => {:in => 2..24 },
            :allow_nil => true


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

  def liked_post?(post)
    self.likes.each do |like |
      return true if like.likeable_type.constantize.find(like.likeable_id) == post
    end
    false
  end

  def id_of_like(post)
    self.likes.each do |like|
      return like.id if like.likeable_type.constantize.find(like.likeable_id) == post
    end
  end
end
