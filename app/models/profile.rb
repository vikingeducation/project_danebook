class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validates :firstname,
            :lastname, 
            :length => { :in => 2..24 }, 
            :presence => true

  validates :gender,
            :presence => true

  validates :college,
            :hometown,
            :currently_lives,
            :length => { :within => 2..30 },
            :allow_blank => true
end
