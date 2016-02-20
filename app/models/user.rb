class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token
  # after_create :create_profile

  has_many :initiated_friendings, class_name: "Friending",
            foreign_key: :friender_id
  has_many :friended_users, through: :initiated_friendings,
              source: :friend_receiver

  has_many :received_friendings, class_name: "Friending",
            foreign_key: :friend_id
  has_many :users_friended_by, through: :received_friendings,
              source: :friend_initiator

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_one :profile, inverse_of: :user

  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  accepts_nested_attributes_for :profile
  
  validates :first_name, :last_name, :email,
                              presence: true

  validates :email, uniqueness: true
  validates :password,
            :length => {:in => 7..72 },
            :allow_nil => true


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

  def liked_resource?(resource)
    self.likes.each do |like|
      return true if like.likeable_type.constantize.find(like.likeable_id) == resource
    end
    false
  end

  def id_of_like(resource)
    self.likes.each do |like|
      return like.id if like.likeable_type.constantize.find(like.likeable_id) == resource
    end
  end

  def friended_user?(friend)
    self.friended_users.include?(friend)
  end

  def sample_friends
    friends = []
    9.times {friends << self.friended_users.sample}
    friends
  end

  def self.find_users(search_name)
    first_name, last_name = search_name.split(' ')
    self.select("*").where("users.first_name LIKE '%#{first_name}%' OR users.last_name LIKE '%#{last_name}%'")
  end
end
