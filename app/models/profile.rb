class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validates :user_id, :presence => true,
                      :uniqueness => true

  validates :college, 
            :hometown, 
            :current_location, 
            :length => { :in => 1..50 }

  validates :telephone, :length => { :in => 10..11 }

  validates :words, :about_me, :length => { :in => 1..300 }
  
end
