class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :gender,
    inclusion: { in: %w(Male Female) },
    allow_nil: true,
    allow_blank: true
  validates :college, :from, :lives,
    length: { maximum: 36 },
    allow_nil: true,
    allow_blank: true
  validates :number,
    format: {with: /\d/},
    length: { maximum: 16 },
    allow_nil: true,
    allow_blank: true
  validates :words, :about,
    length: { maximum: 1000 },
    allow_nil: true,
    allow_blank: true

end
