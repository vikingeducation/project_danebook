class User < ApplicationRecord


  has_one :profile, inverse_of: :user, dependent: :destroy

  before_create :generate_token
  has_secure_password

  validates :first_name,
            :last_name, 
            :email,
            :birth_date,
            :birth_month,
            :birth_year,  
            :presence => true

  validates :first_name, :last_name, :length => { :in => 1..50}

  validates :email, :format => { :with => /@/ }

  validates :birth_date, :inclusion => { :in => 1..31 }
  validates :birth_month, :inclusion => { :in => 1..12 }
  validates :birth_year, :inclusion => { :in => 1900..2017 }

  validates :password, :length => { :in => 6..30 }, 
                       :allow_nil => true

  accepts_nested_attributes_for :profile, :reject_if => :all_blank, 
                                          :allow_destroy => true

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