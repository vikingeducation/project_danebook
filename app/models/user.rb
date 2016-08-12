class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  #belongs_to :hometown, class_name: "City"
  #belongs_to :curr_addr, class_name: "City"

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  validates :birth_date, :first_name, :last_name, :email, :gender, :birth_date, presence: true

  validates :first_name, :last_name, :email, length: { in: (1..50) }
  validates_format_of :email, :with => /@/

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self.auth_token)
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
