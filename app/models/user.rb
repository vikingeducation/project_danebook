class User < ActiveRecord::Base
  has_secure_password
  
  has_one :profile, inverse_of: :user
  accepts_nested_attributes_for :profile

  has_many :posts, foreign_key: :author_id
  has_many :comments
  accepts_nested_attributes_for :comments

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :password, :presence => true, 
                       :confirmation => true,
                       :length => {in: 8..24},
                       :allow_nil => true,
                       :format => {:without => /\s/ }
  validates :gender, :presence => true


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
    self.first_name + " " + self.last_name
  end

  # distinguish post author from timeline
  # post author is currently signed-in user
  # post recipient is whoever is currently 

end
