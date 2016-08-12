class Profile < ApplicationRecord
  belongs_to :user, class_name: "User"

  validates :first_name, length: { :minimum => 1}
  validates :last_name, length: { :minimum => 1}
  validates_confirmation_of :day, in: 1..30, message: 'This site is only for under 30 and over 60'
  validates_confirmation_of :year, in: 1920..2016, message: 'This site is only for under 30 and over 60'
end
