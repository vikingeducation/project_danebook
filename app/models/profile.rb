class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :first_name, :last_name, :gender, :birthday, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
