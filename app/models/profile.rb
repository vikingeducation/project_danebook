class Profile < ActiveRecord::Base

  belongs_to :user

  validates :day, :month, :year, :gender,
                                presence: true

  validates :gender, inclusion: { in: ["Male", "Female", "Another Identity"] }
  validates :day, inclusion: { in: (1..31) }
  validates :month, inclusion: { in: (1..12) }
  validates :year, inclusion: { in: (1905..Time.now.year) }

  validates :college, length: { maximum: 25 }
  validates :hometown, length: { maximum: 35 }
  validates :currently_lives, length: { maximum: 35 }
  validates :telephone, length: { maximum: 25 }

  validates :words_to_live_by, length: { maximum: 140 }
  validates :about_me, length: { maximum: 400 }

end
