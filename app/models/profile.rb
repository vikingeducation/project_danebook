class Profile < ActiveRecord::Base
  belongs_to :user

  # validates :college,
  #           :presence => true,
  #           :on => :update

  # validates :hometown,
  #           :presence => true,
  #           :on => :update

  # validates :currently_lives,
  #           :presence => true,
  #           :on => :update

  # validates :telephone,
  #           :presence => true,
  #           :on => :update

  # validates :words_to_live_by,
  #           :presence => true,
  #           :on => :update

  # validates :about_me,
  #           :presence => true,
  #           :on => :update
end
