class User < ApplicationRecord

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :photos, dependent: :destroy
  belongs_to :profile_photo, class_name: "Photo", optional: true
  belongs_to :cover_photo, class_name: "Photo", optional: true

  has_many :initiated_friendings, :dependent => :destroy,
                                  :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friendee_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  has_many :received_friendings,  :dependent => :destroy,
                                  :foreign_key => :friendee_id,
                                  :class_name => 'Friending'
  has_many :friender_users,       :through => :received_friendings,
                                  :source => :friend_initiator
  before_create :generate_token
  has_secure_password

  validates :first_name,
            :last_name, 
            :email,
            :birth_date,
            :birth_month,
            :birth_year,  
            :presence => true

  validates :first_name, :last_name, :length => { :in => 1..50}

  validates :email, :format => { :with => /@/ },
                    :uniqueness => true

  validates :birth_date, :inclusion => { :in => 1..31 },
                         :numericality => { only_integer: true }
  validates :birth_month, :inclusion => { :in => 1..12 },
                          :numericality => { only_integer: true }
  validates :birth_year, :inclusion => { :in => 1900..2017 },
                         :numericality => { only_integer: true }

  accepts_nested_attributes_for :profile, :reject_if => :all_blank, 
                                          :allow_destroy => true

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

  def friends?(user_id)
    friender_user_ids.include?(user_id) || friendee_user_ids.include?(user_id)
  end

  def number_of_friends
    friender_users.count + friendee_users.count
  end

  def all_friends
    friender_users + friendee_users
  end

  def delete_friendship(friend)
    return false unless friends?(friend.id)
    if friender_user_ids.include?(friend.id)
      friender_users.destroy(friend)
    elsif friendee_user_ids.include?(friend.id)
      friendee_users.destroy(friend)
    end
  end

  def self.send_welcome_email(user_id)
    user = User.find(user_id)
    UserMailer.welcome(user).deliver!
  end

  def newsfeed_posts
    posts = Post.newsfeed(self)
  end


end