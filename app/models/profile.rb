class Profile < ApplicationRecord
  belongs_to :user, class_name: "User"

  validates :first_name, length: { :minimum => 1}
  validates :last_name, length: { :minimum => 1}

  validates :month, presence: true
  validates_format_of :month, with: /[A-Z][a-z]*/

  validates :day, numericality: true
  validates_inclusion_of :day, in: (1..30)

  validates :year, numericality: true
  validates_inclusion_of :year, in: (1900..2016)

  validates_inclusion_of :gender, in: %w(male female)
end
