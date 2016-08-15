class Profile < ActiveRecord::Base
  belongs_to :user

  validates_length_of :college, maximum: 64
  validates_length_of :hometown, maximum: 64
  validates_length_of :currently_lives, maximum: 64
  validates :telephone, presence: true, phone: true

  validates_length_of :words_to_live_by, maximum: 255

  validates_length_of :about_me, maximum: 1000


end
