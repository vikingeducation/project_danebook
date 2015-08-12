class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_secure_password

  validates :password,  :presence => true,
                        :length => {:in => 4..24},
                        :allow_nil => true

  validates :email,     :presence => true,
                        :format => {:with => /@/},
                        :uniqueness => true,
                        :length => {:in => 4..24}
  
  after_create :create_profile
  #after_create :send_delayed_email

  def full_name
      self.first_name + " " + self.last_name
  end

  def likes?(thing)
    Like.where(user: self, liking_id: thing.id, liking_type: thing.class).any?
  end

  private

  def send_delayed_email
    User.delay.send_welcome_email(self.id)
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end
end
