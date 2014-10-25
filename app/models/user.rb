class User < ActiveRecord::Base

  has_secure_password

  validates :password,
            :length => { in: 8..24 },
            allow_nil: true

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :posts
  has_many :likes

  has_many :liked_posts, through: :likes, source: :likable, source_type: "Post"

  before_create :generate_token

  #create new auth token
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Convenience method to regenerate token.
  # Failing with exception is important because it implies tampering.
  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def name
    "#{first_name} #{last_name}"
  end

  def posts_chronologically
    posts.order("created_at DESC")
  end

  def likes_post?(post)
    liked_posts.include?(post)
  end

  def like_of_post(post)
    likes_post?(post) ? likes.find_by(:likable_id => post.id, :likable_type => "Post") : nil
  end

end
