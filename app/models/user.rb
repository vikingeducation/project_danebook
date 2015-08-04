class User < ActiveRecord::Base

  before_create :generate_token
  after_create :build_profile

  has_secure_password

  validates :email, :presence => true,
                    :format => { :with => /@/ }

  validates :password, :presence => true,
                        :length => {:in => 8..25},
                        :on => [:create, :update],
                        :allow_nil => true

  validates :birthdate, :presence => true

  validates :first_name, :last_name, :length => {:in => 1..30}

  has_one :profile

  accepts_nested_attributes_for :profile, :reject_if => :all_blank


  # def build_profile
  #   current_user.profile.create
  # end

  def full_name
    self.first_name + " " + self.last_name
  end


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
