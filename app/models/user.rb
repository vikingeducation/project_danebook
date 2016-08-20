class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  validates :password, 
            :length => { :in => 8..24 }, 
            :allow_nil => true

  validates :email,
            :presence => true,
            :uniqueness => true

  has_one :profile
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :photos

  has_many :initiated_friends, foreign_key: :friender_id, class_name: "Friending"
  has_many :friendeds, through: :initiated_friends, source: :friend_recipient

  has_many :received_friends, foreign_key: :friended_id, class_name: "Friending"
  has_many :frienders, through: :received_friends, source: :friend_initiator

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

  def find_like(obj, type)
    likes.where("likeable_id = ? AND likeable_type = ?", obj.id, type)
  end

  def like_exist?(obj, type)
    !find_like(obj, type).empty?
  end

  def self.get_profile_photo(user)
    Photo.find(user.profile.profile_photo_id)
  end

  def self.get_cover_photo(user)
    Photo.find(user.profile.cover_id)
  end

end
