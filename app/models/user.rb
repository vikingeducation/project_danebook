class User < ActiveRecord::Base
  before_create :generate_token
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 },
                       allow_nil: true
  validates :gender, :inclusion => ["Female",
                                    "Male",
                                    "Other"],
                     :allow_blank => true,
                     :allow_nil => true

  def name
    "#{first_name} #{last_name}"
  end
end
