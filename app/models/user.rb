class User < ApplicationRecord
  has_secure_password
  before_create :generate_token

  validates :password, 
            :length => {:in => 8..24}, 
            :allow_nil => true

  validates :email, uniqueness: {case_sensitive: false}
  validates_format_of :email, :with => /@/

  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile

  has_many :posts
  has_many :photos
  has_many :likes
  has_many :comments

  #when friending someone
  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => "Friending"
  has_many :friended_users, :through => :initiated_friendings, :source => :friend_recipient

  #when receiving a friending
  has_many :received_friendings, :foreign_key => :friend_id, :class_name => "Friending"
  has_many :users_friended_by, :through => :received_friendings, :source => :friend_initiator 

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

  def name
    profile.first_name
  end

  def display_errors(attribute)
    message = ""
    if self.errors[attribute].any?
      message += "#{attribute.capitalize}"
      self.errors[attribute].each do |e|
        message += " #{e}"
      end
    end
    message
  end

  def profile_pic
    photos.find_by profile: true
  end

  def cover_pic
    photos.find_by cover: true
  end

  def last_posted
    posts.order(updated_at: :desc).first.updated_at.strftime("%A %m/%d/%Y")
  end

  def self.post_authors(p_ids)
    where("id IN (?)", p_ids).distinct
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

  def self.send_comment_email(user, commenting_user, type)
    recipient = User.find(user)
    commentor = User.find(commenting_user)
    UserMailer.comment(recipient, commentor, type).deliver
  end

end
