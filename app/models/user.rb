class User < ApplicationRecord
  before_create :generate_token
  after_save { email.downcase.strip }

  has_many :posts, dependent: :destroy
  has_one :profile, inverse_of: :user, dependent: :destroy

  has_many :initiated_friendings, foreign_key: :friender_id,
                                   class_name: "Friending"

  has_many :friended_users, through: :initiated_friendings,
                             source: :friend_recipient

  has_many :received_friendings, foreign_key: :friend_id,
                                  class_name: "Friending"

  has_many :users_friended_by, through: :received_friendings,
                                source: :friend_initiator

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :photos

  accepts_nested_attributes_for :profile

  has_secure_password
  validates :password,
  length: { minimum: 6 },
  allow_nil: true

  validates :email, presence: true,
                    length: { maximum: 255 },
                    :format => /@/,
                    uniqueness: { case_sensitive: false }


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



end
