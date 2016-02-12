class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :gender, inclusion: { in: %w(Male Female) }
  validates :birth_day, inclusion: { in: 1..31 }
  validates :birth_month, inclusion: { in: 1..12 }
  validates :birth_year, inclusion: { in: 1900..2016 }
  validates :college, length: { maximum: 36 }
  validates :from, length: { maximum: 36 }
  validates :lives, length: { maximum: 36 }
  validates :number, format: {with: /\d/}, length: { maximum: 16 }
  validates :words, length: { maximum: 1000 }
  validates :about, length: { maximum: 1000 }
end
