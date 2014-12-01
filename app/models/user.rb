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


# friend requests(one-sided)
  has_many :friend_requests_made, :foreign_key => :requester_id,
                                :class_name => "FriendRequest"

  has_many :friends_requested,   :through => :friend_requests_made,
                                :source  => :requestee


  has_many :friend_requests_received, :foreign_key => :requestee_id,
                                  :class_name => "FriendRequest"
  has_many :friend_requesters,  :through => :friend_requests_received,
                                  :source => :requester



# reciprocal friends after request accepted
  has_many :friendships, :foreign_key => :friender_id,
                                :class_name => "Friending"

  has_many :friends,   :through => :friendships,
                                :source  => :friendee


  has_many :_inverse_friendships, :foreign_key => :friendee_id,
                                  :class_name => "Friending"
  has_many :_inverse_friends,  :through => :_inverse_friendships,
                                  :source => :friender


  before_create :generate_token

  def self.from_omniauth(auth)
    # Do we have a user who already matches the 
    # `provider` and `uid`? 
    # If so, return the first User from that
    # If not, initialize a new user and pass along
    # the attributes we got from the `auth` object

    # logger.info "auth object is #{auth}"
    where( :github_provider => auth.provider, :github_uid => auth.uid ).first_or_initialize.tap do |user|

        user.github_provider = auth.provider
        user.github_uid = auth.uid

        names = auth.info.name.split
        user.first_name, user.last_name = names[0], names[-1]
        user.email = auth.info.email || "placeholder@email"

        # set a randomized password that can never be used
        # omniauth should be the only way in if this is an oauth acct
        user.password = SecureRandom.random_number(36**12).to_s(36).rjust(22, "0")

        user.github_token = auth.credentials.token
        user.github_token_expires = (auth.credentials.expires)
        user.save!
    end
  end



  def self.send_welcome_email(user_id)
    ENV["DELAY_EMAILS"] == "true" ? delay.welcome(user_id) : welcome(user_id)
  end


  #would be private if I could

  def self.welcome(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver
  end


  def self.search(query)
    return none if query.blank?
    queries = query.split
    if queries.size > 1
      where("first_name LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR last_name LIKE ?", "%#{queries[0]}%", 
                                     "%#{queries[0].capitalize}%",
                                     "%#{queries[1]}%",
                                     "%#{queries[1].capitalize}%" )
    else
      where("first_name LIKE ? OR first_name LIKE ? OR last_name LIKE ? OR last_name LIKE ?", "%#{queries[0]}%", 
                                     "%#{queries[0].capitalize}%",
                                     "%#{queries[0]}%",
                                     "%#{queries[0].capitalize}%" )
    end

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
