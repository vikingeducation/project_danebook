class User < ActiveRecord::Base
  validates :email,    presence: { message: "Must have an email." },
                       uniqueness: true
  validates :password, length:   { in: 6..20 },
                       allow_nil: true


  has_secure_password

  has_many :posts, 
           :dependent => :destroy
  has_many :comments, 
           :dependent => :destroy
  has_many :likes, 
           :dependent => :destroy
  has_one  :profile, 
           :dependent => :destroy

  accepts_nested_attributes_for :profile

  # When acting as the initiator of the friending
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending", 
                                  :dependent => :destroy
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient
                                  
  # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending", 
                                  :dependent => :destroy
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

  def num_of_friends
    friended_users.count
  end

  def display_num_of_friends
    if (0..1).include?(num_of_friends)
      "#{num_of_friends} friend"
    elsif num_of_friends > 1
      "#{num_of_friends} friends"
    end
  end

  def has_friended?(user)
    friended_users.include?(user)
  end

end
