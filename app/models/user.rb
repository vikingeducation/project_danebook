class User < ActiveRecord::Base
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
end
