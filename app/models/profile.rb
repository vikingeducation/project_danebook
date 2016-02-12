class Profile < ActiveRecord::Base
  belongs_to :user, inverse_of: :profile

  validates :gender, inclusion: { in: %w(Male Female) }
  validates :college, length: { maximum: 36 }
  validates :from, length: { maximum: 36 }
  validates :lives, length: { maximum: 36 }
  validates :number, format: {with: /\d/}, length: { maximum: 16 }
  validates :words, length: { maximum: 1000 }
  validates :about, length: { maximum: 1000 }
end
