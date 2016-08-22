class User < ApplicationRecord
  before_create :generate_token

  has_secure_password
  validates :email, 
            :presence => {:message => "Please enter an email"},
            :format => { :with => /@/, :message => "Please enter a valid email address" },
            :uniqueness => true
  validates :password,
            :length => {:minimum => 6},
            :on => :create
  has_one :profile

  has_many :photos, foreign_key: :user_id

  
  
  accepts_nested_attributes_for :profile, :update_only => true
  has_many :posts_written, :foreign_key => :post_author_id, :class_name => "Post"
  has_many :posts_received, :foreign_key => :post_receiver_id, :class_name => "Post"
  has_many :comments_written, :foreign_key => :user_id, :class_name => "Comment"
  has_many :likes_given, :foreign_key => :user_id, :class_name => "Like"
  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => "Friending"
  has_many :friended_users, :through => :initiated_friendings, :source => :friend_recipient

  has_many :received_friendings, :foreign_key => :friended_id, :class_name => "Friending"
  has_many :users_friended_by, :through => :received_friendings, :source => :friend_initiator

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    self.save!
  end

  def likes_post?(id, type)
    self.likes_given.where("likeable_id = ? AND likeable_type = ?", id, type)
  end

  def friend_count
    self.friends.size
  end

  def friends
    (self.friended_users + self.users_friended_by).uniq
  end

  def self.search(search, id)
    users = []
    if search
      all_terms = search.split
      all_terms.each do |term|
        term_users = User.joins(:profile).where('first_name ILIKE ? OR last_name ILIKE ?', "%#{term}%", "%#{term}%")
        term_users.each do |term_user|
          users << term_user
        end
      end
      users.uniq
    else
      User.all
    end
  end

  def profile_picture
    photo = self.profile.prof_photo
    photo.image
  end

  def cover_photo
    photo = self.profile.cover_photo
    photo.image
  end
  private
  class << self
    def welcome_email(id)
      user = User.find(id)
      UserMailer.welcome(user).deliver
    end

    # handle_asynchronously :welcome_email, run_at: Proc.new { 5.seconds.from_now }

    def comment_email(owner_id, commenter_id, comment_id, post_id)
      owner_user = User.find(owner_id)
      comment_user = User.find(commenter_id)
      comment = Comment.find(comment_id)
      UserMailer.comment(owner_user, comment_user, comment).deliver!
    end

    # handle_asynchronously :comment_email, run_at: Proc.new {5.seconds.from_now}

  end



end
