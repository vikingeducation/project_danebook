class User < ActiveRecord::Base
  validates :email, presence: { message: "Must have an email." },
                    uniqueness: true
  validates :password, presence: { message: "Must have a password." }
end
