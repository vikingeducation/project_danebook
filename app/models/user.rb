class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendings, dependent: :destroy

  has_many :friends, through: :friendings 


  has_secure_password

  validates :password,  :presence => true,
                        :length => {:in => 4..24},
                        :allow_nil => true

  validates :email,     :presence => true,
                        :format => {:with => /@/},
                        :uniqueness => true,
                        :length => {:in => 4..24}
  
  after_create :create_profile

  def full_name
      self.first_name + " " + self.last_name
  end

  def likes?(thing)
    Like.where(user: self, liking_id: thing.id, liking_type: thing.class).any?
  end

  def self.search(word)
    User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{word}%", "%#{word}%")
  end

  def self.create_profile
    Profile.new(user_id: self.id)
  end
end
