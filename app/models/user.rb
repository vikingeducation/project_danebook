class User < ActiveRecord::Base

  has_one :profile
  has_many :posts
  has_many :comments
  has_many :likes

  #intiating friendships
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient
  
  #recieving friendships.
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  before_create :generate_token
  #build a profile after user being created
  after_create :build_profile
  
  has_secure_password
  
  validates :first_name, :last_name, :presence => true
  validates :email, :presence => true, :format => { :with => /@/ }
  # validates :password, :presence => true,
  #           :on => [:create, :update],
  #           :length => {:in => 8..16},
  #           :allow_nil => false

  
 

 def self.search(search)
   User.where("first_name like :s or last_name like :s or first_name || ' ' || last_name like :s", :s => "%#{search}")
end

  
                                      
  def full_name
     self.first_name + " " + self.last_name
  end

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

  # def remember_me
  #   self.remember_token_expires = 2.weeks.from_now
  #   self.remember_token = Digest::SHA1.hexdigest(“#{salt}—#{self.email}—#{self.remember_token_expires}”)
  #   self.password = "" # This bypasses password encryption, thus leaving password intact
  #   self.save_with_validation(false)
  # end

  def forget_me
   self.remember_token_expires = nil 
   self.remember_token = nil 
   self.password = "" # This bypasses password encryption, thus leaving password intact self.save_with_validation(false) end
  end
end
