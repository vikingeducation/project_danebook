class User < ActiveRecord::Base


  # has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/harry_potter_profile.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  # validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes
  #
  # has_attached_file :cover, styles: { large: "400x400>" }, default_url: "/images/hogwarts_small.jpg"
  # validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  # validates_with AttachmentSizeValidator, attributes: :cover, less_than: 5.megabytes

  has_many :photos, dependent: :destroy
  belongs_to :avatar, class_name: "Photo"
  belongs_to :cover, class_name: "Photo"
# ======================================================
  has_secure_password
# ======================================================
  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, inverse_of: :user, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending"
  has_many :friendeds, through: :initiated_friendings

  has_many :received_friendings, foreign_key: :friended_id, class_name: "Friending"
  has_many :frienders, through: :received_friendings

  has_many :activities, dependent: :destroy
# ======================================================
  accepts_nested_attributes_for :posts,
    reject_if: proc { |attributes| attributes['body'].blank? },
    allow_destroy: :true
# ======================================================
  validates :password, length: { in: 8..24 }, allow_nil: true
  validates :first_name, :last_name, presence: true, length: { in: 1..64 }
  validates :email, presence: true, format: { with: /@{1}/ }, length: { minimum: 3 }, uniqueness: true
# ======================================================
  before_create :generate_token
# ======================================================

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def get_activities
    friends = friendeds.includes(activities: :activable)
    activities = []
    friends.each { |f| activities << f.activities }
    activities[0]
  end

  def generate_token
    self.auth_token = SecureRandom.uuid + "-" +  Digest::MD5.hexdigest("#{email}")
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
