class User < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  has_one :profile

  has_secure_password

  accepts_nested_attributes_for :profile

  # ----------------------- Validations --------------------

  validates :first_name, :last_name, :email,
            :length => { :in => 1..30 },
            :presence => true

  validates :email,
            :format => { :with => /@/ }

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  before_create :generate_token

  # ----------------------- Methods --------------------

  def name
    "#{first_name} #{last_name}"
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

end
