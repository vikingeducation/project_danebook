class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :gender,
    inclusion: { in: %w(Male Female) },
    allow_nil: true,
    allow_blank: true
  validates :college, :from, :lives,
    length: { maximum: 140 },
    allow_nil: true,
    allow_blank: true
  validates :number,
    length: { maximum: 30 },
    allow_nil: true,
    allow_blank: true
  validates :words, :about,
    length: { maximum: 2000 },
    allow_nil: true,
    allow_blank: true

  validates :user, presence: true
end
