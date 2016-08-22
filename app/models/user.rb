class User < ApplicationRecord
  before_create :generate_token
  has_secure_password

  belongs_to :hometown, class_name: "City", optional: true
  belongs_to :residency, class_name: "City", optional: true
  belongs_to :cover_photo, class_name: "Photo", optional: true
  belongs_to :profile_photo, class_name: "Photo", optional: true
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: :commenter_id, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_many :initiated_friendships,
                              foreign_key: :friender_id,
                              class_name: "Friendship"
  has_many :friended_users,
                              through: :initiated_friendships,
                              source: :friended


  has_many :received_friendships,
                              foreign_key: :friended_id,
                              class_name: "Friendship"
  has_many :users_friended_by,
                              through: :received_friendships,
                              source: :friender

  accepts_nested_attributes_for :hometown,
                                :reject_if => :all_blank
  accepts_nested_attributes_for :residency,
                                :reject_if => :all_blank

  validates :password,
            :length => { :in => 6..24 },
            :allow_nil => true

  validates :birth_date, :first_name, :last_name, :email, :gender, :birth_date, presence: true

  validates :first_name, :last_name, :email, length: { in: (1..50) }
  validates_format_of :email, :with => /@/
  validates :email, uniqueness: true
  validates :college, length: { maximum: 50 }
  validates :telephone, length: { maximum: 20 }
  validates :quote, length: { maximum: 255 }
  validates :about, length: { maximum: 1000 }

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def name
    first_name + " " + last_name
  end

  ######## EMAILS ###############
  def self.send_welcome_email(user_id)
    @user = User.find(user_id)
    UserMailer.welcome(@user).deliver!
  end

  def self.send_activity_email(user_id, comment_id)
    @user = User.find(user_id)
    @comment = Comment.find(comment_id)
    UserMailer.activity(@user, @comment).deliver!
  end

  ######## SEARCH ###############
  def self.search(query)
    if query
      where("first_name ILIKE ? OR last_name ILIKE ?", "%#{query}%", "%#{query}%")
    else
      where("")
    end
  end


  def profile_photo_id=(id)
    id = id.to_i
    self.profile_photo = Photo.find(id) if self.photo_ids.include?(id)
  end

  def cover_photo_id=(id)
    id = id.to_i
    self.cover_photo = Photo.find(id) if self.photo_ids.include?(id)
  end

  def cover_url
    self.cover_photo.nil? ? "https://c2.staticflickr.com/2/1219/1281974700_b90fe6d7e9_b.jpg" : self.cover_photo.image.url
  end

  def profile_url
    self.profile_photo.nil? ? "/orm_profile.jpg" : self.profile_photo.image.url
  end

  def is_friend?(user)
    self.friended_user_ids.include?(user.id)
  end

  def sample_friends(size)
    count = self.friended_users.count < size ?
                            self.friended_users.count :
                            size

    id_list = self.friended_user_ids.sample(count)

    friends = []
    id_list.each do |id|
      friends << User.find(id)
    end

    friends
  end
end
