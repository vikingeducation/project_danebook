class User < ActiveRecord::Base
  has_one :profile
  has_many :posts
  has_many :comments

  has_secure_password

  before_create :generate_token

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
