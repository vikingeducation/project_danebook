class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token
  after_create :profile_create

  has_many :posts
  has_one :profile
  has_many :likes
  has_many :comments

  #When acting as the initiator
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"

  has_many :friended_users, :through => :initiated_friendings,
                            :source => :friend_recipient

  #When acting as the recipient of the friending
  has_many :recieved_friendings, :foreign_key => :friend_id,
                                 :class_name => "Friending"

  has_many :users_friended_by, :through => :recieved_friendings,
                               :source => :friend_initiator
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, :dob, :gender, presence: true
  validates :password, presence: true, length: {in: 7..24}, confirmation: true, :on=> [:new]

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
    self.first_name + " " + self.last_name
  end

  def self.find_user_by_keyword(string)
    self.all.where("first_name LIKE ? OR last_name LIKE ?", "#{string}%", "#{string}%")
  end

  private

   def profile_create
    self.profile = Profile.new
   end



end
