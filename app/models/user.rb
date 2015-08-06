class User < ActiveRecord::Base
  validates :email,    presence: { message: "Must have an email." },
                       uniqueness: true
  validates :password, length:   { in: 1..20 },
                       allow_nil: true
  has_secure_password

  before_create :generate_token

  has_one :profile

  accepts_nested_attributes_for :profile

  has_many :posts
  has_many :likes
  has_many :comments


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

  def like?(likable_id, likable_type)
    likes.where(likable_id: likable_id, likable_type: likable_type).any?
  end

  def get_like_id(likable_id, likable_type)
    like?(likable_id, likable_type) ? likes.where(likable_id: likable_id, likable_type: likable_type)[0].id : nil
  end
end
