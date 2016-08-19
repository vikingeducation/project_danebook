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

  private
  class << self
    def welcome_email(id)
      user = User.find(id)
      UserMailer.welcome(user).deliver
    end

    handle_asynchronously :welcome_email, run_at: Proc.new { 5.seconds.from_now }

    def comment_email(owner_id, commenter_id, comment_id, post_id)
      owner_user = User.find(owner_id)
      comment_user = User.find(commenter_id)
      comment = Comment.find(comment_id)
      post = Post.find(post_id)
      UserMailer.comment(owner_user, comment_user, comment, post).deliver!
    end

    handle_asynchronously :comment_email, run_at: Proc.new {5.seconds.from_now}

  end



end
