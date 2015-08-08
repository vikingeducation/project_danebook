class User < ActiveRecord::Base
  validates :email,    presence: { message: "Must have an email." },
                       uniqueness: true
  validates :password, length:   { in: 6..20 },
                       allow_nil: true
  has_secure_password

  has_many :posts
  has_many :likes
  has_many :comments

  has_one :profile

  accepts_nested_attributes_for :profile

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

  before_create :generate_token

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

  def get_likes(likable_id, likable_type)
    likes.where(likable_id: likable_id, likable_type: likable_type)
  end

  def like?(likable_id, likable_type)
    get_likes(likable_id, likable_type).any?
  end

  def get_like_id(likable_id, likable_type)
    like?(likable_id, likable_type) ? get_likes(likable_id, likable_type).pluck(:id)[0] : nil
  end
end
