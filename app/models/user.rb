class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  # has_secure_password
  has_one :profile, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :profile
  validates :email, presence: true, uniqueness: true, length: { minimum: 6}
  validates :password, :password_confirmation, presence: true, length: {minimum: 12 }, on: :create
  validates_associated :profile

  def first_name
    profile.first_name
  end

  def birthday
    self.profile.birthdate.strftime('%B %e, %Y')
  end


end
