class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :college,
            :length => { :in => 0..30 },
            :allow_nil => true
  validates :hometown,
            :length => { :in => 0..30 },
            :allow_nil => true
  validates :city,
            :length => { :in => 0..30 },
            :allow_nil => true
  validates :telephone,
            :length => { :in => 0..14 },
            :allow_nil => true
  validates :words_to_live_by,
            :length => { :in => 0..5000 },
            :allow_nil => true
  validates :about_me,
            :length => { :in => 0..5000 },
            :allow_nil => true
end