class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validates :user_id, :presence => true,
                      :uniqueness => true

  validates :college, 
            :hometown, 
            :current_location, 
            :length => { :maximum => 50 }

  validates :telephone, :length => { :maximum => 11 }

  validates :words, :about_me, :length => { :maximum => 300 }
  
end
