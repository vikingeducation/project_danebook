class Profile < ApplicationRecord
  belongs_to :user, optional: true
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

  has_attached_file :profile_picture, :styles => { :profile => "150x150", :post => "75x75" }, default_url: "https://s3.amazonaws.com/viking_education/web_development/web_app_eng/user_silhouette_generic.gif"
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/


end
