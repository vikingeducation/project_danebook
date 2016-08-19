class Profile < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :prof_photo, optional: true
  belongs_to :cover_photo, optional: true
  accepts_nested_attributes_for :cover_photo
  accepts_nested_attributes_for :prof_photo
  validates :first_name, 
            :length => {:maximum => 40}, allow_blank: true,             allow_nil: true

  validates :last_name, 
            :length => {:maximum => 40}, allow_blank: true,             allow_nil: true

  validates :college, 
            :length => {:maximum => 40}, allow_blank: true,             allow_nil: true

  validates :hometown, 
            :length => {:maximum => 40}, allow_blank: true,             allow_nil: true

  validates :currently_lives, 
            :length => {:maximum => 40}, allow_blank: true,             allow_nil: true

  validates :words_to_live_by, 
            :length => {:maximum => 300}, allow_blank: true,             allow_nil: true

  validates :about_me, 
            :length => {:maximum => 300}, allow_blank: true,             allow_nil: true

  validates_date :birthday,
                 :message => "Please enter a real date",
                 :before => lambda {Date.current},
                 :before_message => "Get real. You can't be born in the future!",
                 allow_nil: true,
                 allow_blank: true
  validates :telephone,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 },
            :on => :update,
            allow_nil: true,
            allow_blank: true



end
