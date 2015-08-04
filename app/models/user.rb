class User < ActiveRecord::Base

  before_create :generate_token

  has_secure_password

  validates :email, :presence => true,
                    :format => { :with => /@/ }

  validates :password, :presence => true,
                        :length => {:in => 8..25},
                        :on => [:create, :update],
                        :allow_nil => true

  validates :first_name, :last_name, :length => {:in => 1..30}


  has_one :birthdate




  #sign in cookies!
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
