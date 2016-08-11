class User < ActiveRecord::Base
  has_one :profile
  accepts_nested_attributes_for :profile

  before_create :generate_token

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
  validates :first_name, :last_name,
            :presence => true,
            :length => { :minimum => 2 },
            :allow_nil => true
  validates :birth_date,
           :presence => true,
           :allow_nil => true

  # unfamiliar syntax, but similar to `do_stuff if condition`
  # We'll keep trying to generate the token as long as there's
  # one identical to it somewhere in our users table
  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  # Make a convenience method for regenerating the token
  # when we need it
  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end
end
