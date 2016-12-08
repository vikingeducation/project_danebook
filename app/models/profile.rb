class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validates :gender, :first_name, :last_name, presence: true

  #validates_presence_of :user
end
