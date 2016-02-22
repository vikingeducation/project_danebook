class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300", :thumb => "100x100" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
# ======================================================
  has_secure_password
# ======================================================
  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, inverse_of: :user, dependent: :destroy
  has_many :comments

  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending"
  has_many :friendeds, through: :initiated_friendings

  has_many :received_friendings, foreign_key: :friended_id, class_name: "Friending"
  has_many :frienders, through: :received_friendings

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

  def generate_token
    self.auth_token = SecureRandom.uuid + "-" +  Digest::MD5.hexdigest("#{email}")
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
