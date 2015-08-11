class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments

  # Self Associations
  has_many :initiated_friendings, foreign_key: :friender_id,
  class_name: "Friending"
  has_many :friended_users,      through: :initiated_friendings,
  source: :friend_recipient                                 

  has_many :received_friendings,  foreign_key: :friend_id,
  class_name: "Friending"
  has_many :users_friended_by,    through: :received_friendings,
  source: :friend_initiator

  #AUTH
  #                                                                  
  has_secure_password

  before_create  :generate_token
  after_create :make_profile

  def make_profile
    self.build_profile.save
  end

  def generate_token
    begin 
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token]) 
  end

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def friends
    sql = "
    SELECT DISTINCT users.*
    FROM users
    JOIN friendings
    ON users.id = friendings.friender_id
    JOIN friendings AS reflected_friendings
    ON reflected_friendings.friender_id = friendings.friend_id
    WHERE reflected_friendings.friender_id = ?
    "

    # Pass in our sql and the User id that we're expecting
    # Note that these are a single Array input
    # because find_by_sql is weird.
    User.find_by_sql([sql,self.id])
  end
end
