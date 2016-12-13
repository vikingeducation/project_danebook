class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  validates :birth_month, inclusion: { in: 1..12 }
  validates :birth_day, inclusion: { in: 1..31 }
  validates :birth_year, inclusion: { in: 1916..2016 }
  validates :gender, inclusion: %w(Male Female)
  validates :user, presence: true  

end
