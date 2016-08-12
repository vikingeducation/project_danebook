class Profile < ApplicationRecord
  belongs_to :user, optional: true
  validates :college, 
            :length => {:maximum => 40, :message => "has a maximum of 40 characters"}
  validates :hometown, 
            :length => {:maximum => 40, :message => "has a maximum of 40 characters"}
  validates :currently_lives, 
            :length => {:maximum => 40, :message => "has a maximum of 40 characters"}
  validates :words_to_live_by, 
            :length => {:maximum => 300, :message => "has a maximum of 300 characters"}
  validates :about_me, 
            :length => {:maximum => 300, :message => "has a maximum of 300 characters"}
  validates_date :birthday,
                 :message => "Please enter a real date",
                 :before => lambda {Date.current},
                 :before_message => "Get real. You can't be born in the future!"


end
