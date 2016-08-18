class User < ApplicationRecord
  before_create :generate_token
  after_create :profile

  has_secure_password
  validates :email, 
            :presence => {:message => "Please enter an email"},
            :format => { :with => /@/, :message => "Please enter a valid email address" },
            :uniqueness => true
  validates :password,
            :length => {:minimum => 6},
            :on => :create
  has_one :profile
  accepts_nested_attributes_for :profile, :update_only => true
  has_many :posts_written, :foreign_key => :post_author_id, :class_name => "Post"
  has_many :posts_received, :foreign_key => :post_receiver_id, :class_name => "Post"
  has_many :comments_written, :foreign_key => :user_id, :class_name => "Comment"
  has_many :likes_given, :foreign_key => :user_id, :class_name => "Like"

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



end
