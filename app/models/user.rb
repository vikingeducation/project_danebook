class User < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy, inverse_of: :user
  has_many :posts
  has_many :comments

  has_many :initiated_friendings, foreign_key: :friender_id, class_name: "Friending", dependent: :destroy
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient
  has_many :received_friendings, foreign_key: :friend_id, class_name: "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  accepts_nested_attributes_for :profile, reject_if: :all_blank

  validates :first_name, :presence, length: { maximum: 25 }
  validates :last_name, :presence, length: { maximum: 25 }
  validates :email, presence:true, length: { maximum: 50 }, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 256 }, allow_nil: true

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
    self.first_name + ' ' + self.last_name
  end

end
