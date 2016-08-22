class User < ApplicationRecord
  has_secure_password

  validates :username, length: { :minimum => 1}, uniqueness: true
  validates :email, uniqueness: true
  validates_format_of :email, :with => /@.*[.]com\z/
  #validates :password, :allow_nil => false#, length: { in: (5..26) }
  before_create :generate_token

  has_one :profile, class_name: "Profile"
  has_many :posts, class_name: "Post"
  has_many :comments, class_name: "Comment"

  has_many :likes, :as => :likeable, class_name: "Liking"
  has_many :photos, :as => :photoable, class_name: "Photo"

  # When acting as the initiator of the friending
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  #generates and regenerates tokens and sets to self
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

  def already_likes?
    !likes.empty?
  end

   def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

  def self.search(query)
    if query
      where("username LIKE ?", "%#{query}%")
    else
      where("")
    end
  end
end
