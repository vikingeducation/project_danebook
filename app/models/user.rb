class User < ActiveRecord::Base

  has_secure_password

  validates :password,
            :length => { in: 8..24 },
            allow_nil: true

  validates_uniqueness_of :email

  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :comments
  has_many :posts
  has_many :likes
  has_many :photos


  belongs_to :profile_photo, class_name: "Photo"
  belongs_to :cover_photo, class_name: "Photo"




  has_many :liked_posts, through: :likes, source: :likable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likable, source_type: "Comment"
  has_many :liked_photos, through: :likes, source: :likable, source_type: "Photo"


  has_many :friendship_requests_made, :foreign_key => :friender_id,
                                :class_name => "Friending"

  has_many :friends,   :through => :friendship_requests_made,
                                :source  => :friendee


  has_many :friendship_requests_received, :foreign_key => :friendee_id,
                                  :class_name => "Friending"
  has_many :friend_requesters,  :through => :friendship_requests_received,
                                  :source => :friender


  before_create :generate_token

  def self.send_welcome_email(user_id)
    ENV["DELAY_EMAILS"] ? delay.welcome(user_id) : welcome(user_id)
  end


  #would be private if I could
  def self.welcome(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver
  end


  def self.search(query)
    where("first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%")
  end

  def has_friend?(user)
    friends.include?(user)
  end

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

  # does this user like that post?
  def likes_post?(post)
    liked_posts.include?(post)
  end

  # does this user like that comment?
  def likes_comment?(comment)
    liked_comments.include?(comment)
  end

  # does this user like that photo?
  def likes_photo?(photo)
    liked_photos.include?(photo)
  end

  # given a comment, returns this user's Like of that comment from
  # the Likes table. If this user doesn't like that comment, returns nil
  def like_of_comment(comment)
    likes_comment?(comment) ? likes.find_by(:likable_id => comment.id, :likable_type => "Comment") : nil
  end

  # given a comment, returns this user's Like of that comment from
  # the Likes table. If this user doesn't like that comment, returns nil
  def like_of_photo(photo)
    likes_photo?(photo) ? likes.find_by(:likable_id => photo.id, :likable_type => "Photo") : nil
  end

  # given a post, returns this user's Like of that post from the Likes table.
  # If this user doesn't like that post, returns nil
  def like_of_post(post)
    likes_post?(post) ? likes.find_by(:likable_id => post.id, :likable_type => "Post") : nil
  end

end
