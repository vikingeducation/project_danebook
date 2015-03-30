class User < ActiveRecord::Base


  has_secure_password

  validates_presence_of :first_name, :last_name, :email
  validates :password,
            :length => { in: 8..24 },
            allow_nil: true

  validates_uniqueness_of :email


# BASIC ASSOCIATIONS
  has_one :profile
  accepts_nested_attributes_for :profile

  has_many :comments
  has_many :posts
  has_many :likes
  has_many :photos

# PHOTOS
  belongs_to :profile_photo, class_name: "Photo"
  belongs_to :cover_photo, class_name: "Photo"





# LIKES
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


  after_create :get_a_friend


  # Do we have a user who already matches the
  # `provider` and `uid`?
  # If so, return that user
  # otherwise, build one if possible
  def self.from_omniauth(auth)
    if user = find_by( :github_provider => auth.provider, :github_uid => auth.uid )
      return user
    else
      build_from_github(auth)
    end
  end



  # builds a new account for a Github user
  # set a randomized password that can never be used
  # fails to save if the user doesn't have an email
  # omniauth should be the only way in if this is an oauth acct
  def self.build_from_github(auth)
    user = User.new(:github_provider => auth.provider,
                    :github_uid => auth.uid,
                    :first_name => auth.info.name.split[0],
                    :last_name => auth.info.name.split[-1],
                    :email => (auth.info.email if auth.info.email.present?),
                    :password => SecureRandom.random_number(36**12).to_s(36).rjust(22, "0"),
                    :github_token => auth.credentials.token,
                    :github_token_expires => auth.credentials.expires )

    user.build_profile( :gender => "Not Provided",
                        :year => 1901,
                        :month => 1,
                        :day => 1 )

    user.save && user.profile.save ? user : nil
  end



  def self.send_welcome_email(user_id)
    ENV["DELAY_EMAILS"] == "true" ? delay.welcome(user_id) : welcome(user_id)
  end


  def self.welcome(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver
  end



  # searches all existing Users by a query string for names
  # intentionally case-insensitive, so "michael" finds all Michaels
  #
  # User.search("Michael Alexander") finds all users firstnamed Michael
  # AND all users lastnamed Alexander
  #
  # Additionally, partial matches work:
  # User.search("mich") finds Michael Alexander, Denise Michaels and Michie Michigan
  #
  # Finally, a one-word query matches on both firstnames and last-names
  # a multi-word query matches first word on firstnames, second word on lastnames
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


  # master boolean for checking what a user likes
  # user.likes?(a_post_she_likes) => true
  # user.likes?(a_comment_he_does_not_like) => false

  def likes?(likable_object)
    Like::LIKABLES.any? do |likable_type|
      self.send( "liked_#{ likable_type }" ).include?( likable_object )
    end
  end



  # given a Likable(post/comment/photo), returns this user's Like of that
  # comment from the Likes table. If this user doesn't like that comment,
  # returns nil

  def like_of(likable)
    likes?(likable) ? likes.find_by(:likable_id => likable.id, :likable_type => likable.class.name) : nil
  end


  # returns the most recent posts in newsfeed
  def newsfeed
    Post.newsfeed_for(self)
  end

  private

  #everybody but the first user friends the first user
  def get_a_friend
    unless self == User.first
      friends << User.first
    end
  end
end
