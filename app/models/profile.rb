class Profile < ApplicationRecord
  belongs_to :user

  validates_length_of :college, :hometown, :currently_lives, maximum: 64

  validates :telephone, phone: { possible: true, allow_blank: true }

  validates_length_of :words_to_live_by, maximum: 255

  validates_length_of :about_me, maximum: 1000
end
