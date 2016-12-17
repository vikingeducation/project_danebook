class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :authored_posts, class_name: "Post",foreign_key: :author_id, dependent: :destroy
  has_many :liked_things, foreign_key: :liker_id, class_name: "Like", dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :photos, foreign_key: :owner_id, dependent: :destroy

  has_many :initiated_friendings,
      foreign_key: :friender_id,
      class_name: "Friending"
  has_many :friended_users,
      through: :initiated_friendings,
      source: :friend_recipient
  has_many :received_friendings,
      foreign_key: :friended_id,
      class_name: "Friending"
  has_many :users_friended_by,
      through: :received_friendings,
      source: :friend_initiator

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :photos
  validates :password, 
            :length => { :in => 8..30 }, 
            :allow_nil => true
  validates :first_name,
            length: { in: 2..20 }
  validates :last_name,
            length: { in: 2..20 }

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

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def friends
    self.friended_users + self.users_friended_by
  end

end
