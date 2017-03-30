class User < ApplicationRecord


  before_create :generate_token
  before_create :create_profile

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, :reject_if => :all_blank, :allow_destroy => true

  has_many :posts, :foreign_key => :user_id

  has_many :likes
  has_many :comments

  has_many :liked_posts, through: :likes, source: :likable, source_type: "Post"
  has_many :liked_comments, through: :likes, source: :likable, source_type: "Comment"
  has_many :liked_photos, through: :likes, source: :likable, source_type: "Photo"

  # when acting as the initiator of the friending
  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient

  # when acting as the recipient of the friending
  has_many :received_friendings, foreign_key: :friend_id, class_name: "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  has_many :photos

  belongs_to :profile_photo, class_name: "Photo"
  belongs_to :cover_photo, class_name: "Photo"

  has_secure_password

  validates :password, :length => { :in => 3..24 }, :allow_nil => true
  validates :first_name,
            :last_name, length: { :in => 1..12 }, presence: true
  validates :email, length: { :in => 1..24 }, presence: true, uniqueness: true

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
    "#{first_name} #{last_name}"
  end

  def likes?(likable_obect)
    Like::LIKABLES.any? do |likable_type|
      self.send("liked_#{likable_type}").include?(likable_object)
    end
  end

  def like_of(likable)
    likes?(likable) ? likes.find_by(:likable_id => likable.id, :likable_type => likable.class.name) : nil
  end

end
