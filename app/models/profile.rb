class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :user, presence: true
  validates :first_name, :last_name, presence: true
end
