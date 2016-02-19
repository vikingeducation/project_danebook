class User < ActiveRecord::Base

  has_one  :profile,  dependent:   :destroy
  has_many :posts,    dependent:   :destroy
  has_many :comments, dependent:   :destroy
  has_many :likes,    dependent:   :destroy
  
  has_many :commented_posts, through: :comments, source: :commentable, source_type: 'Post'
  has_many :liked_posts, through: :likes, source: :likeable, source_type: 'Post'

  # When acting as the initiator of the friending
  has_many :initiated_friend_requests, :foreign_key => :friend_requestor_id,
                             :class_name => "Friendship"
  has_many :friends,         :through => :initiated_friend_requests,
                             :source => :friend_receiver

  # When acting as the recipient of the friending
  has_many :received_friend_requests,  :foreign_key => :friend_receiver_id,
                                       :class_name => "Friending"
  has_many :users_friended_by,         :through => :received_friend_requests,
                                       :source => :friend_requestor 

  before_create :generate_token
  has_secure_password

  validates :username, :email, :uniqueness => true
  validates :username, :email, :presence => true
  
  #validates_format_of   :email,     without: /NOSPAM/
  validates :password,
            :length => {:in => 8..20},
            :allow_nil => true


  accepts_nested_attributes_for :profile,
                               :reject_if => :all_blank,
                               :allow_destroy => true
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Make a convenience method for regenerating the token 
  # when we need it
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def full_name
    first_name + " " + last_name
  end
  
  def recent_posts
    self.posts.order("id DESC")
  end  
end
