class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true



end
