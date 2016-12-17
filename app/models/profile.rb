class Profile < ApplicationRecord

  belongs_to :user, inverse_of: :profile

  belongs_to :profile_photo, class_name: 'Photo', foreign_key: :photo_id, optional: true
  belongs_to :cover_photo, class_name: 'Photo', foreign_key: :cover_photo_id, optional: true

  validates :birth_month, inclusion: { in: 1..12 }
  validates :birth_day, inclusion: { in: 1..31 }
  validates :birth_year, inclusion: { in: 1916..2016 }
  validates :gender, inclusion: %w(Male Female)
  validates :user, presence: true  

end
