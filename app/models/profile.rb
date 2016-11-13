class Profile < ApplicationRecord

  belongs_to :user

  validates :about_me, :words_to_live_by, :length => { maximum: 250 }
  validates :hometown, :current_city, :telephone, :college, :length => { maximum: 70 }

end
