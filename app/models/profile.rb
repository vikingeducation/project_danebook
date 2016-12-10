class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, inverse_of: :profile
  validates :college, :length => { :in => 0..30 }
  validates :hometown, :length => { :in => 0..30 }
  validates :city, :length => { :in => 0..30 }
  validates :telephone, :length => { :in => 0..14 }
  validates :words_to_live_by, :length => { :in => 0..500 }
  validates :about_me, :length => { :in => 0..500 }
end