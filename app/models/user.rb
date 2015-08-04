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

  # validates :birth_month,
  #               numericality: { :greater_than_or_equal_to => 1,
  #                               :less_than_or_equal_to => 31 }
  # validates :birth_day,
  #               numericality: { :greater_than_or_equal_to => 1,
  #                               :less_than_or_equal_to => 31 }
  # validates :birth_year,
  #               numericality: { :greater_than_or_equal_to => 1,
  #                               :less_than_or_equal_to => 31 }

  # has_one :birthdate_listing

  # accepts_nested_attributes_for :birthdates, :reject_if => :all_blank




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
