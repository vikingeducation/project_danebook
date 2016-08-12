class User < ActiveRecord::Base
  has_secure_password
  
  has_one :profile
  after_create :create_profile

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates :password, :presence => true, 
                       :confirmation => true,
                       :length => {in: 8..24},
                       :allow_nil => true,
                       :format => {:without => /\s/ }
  validates_date :birth_date, :before => lambda { 18.years.ago },
                               :before_message => " invalid. You must be at least 18 years old."
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

end
