class Profile < ApplicationRecord

  belongs_to :user
  validates_presence_of :user

  validates :first_name, 
            :last_name, 
            :college, 
            :hometown, 
            :current_town, :length => { :within => 2..20 }

  validates :words_to_live, 
            :about_me, :length => { :within => 20..250 }

  validates :telephone, :length => { :within => 6..20 },
                        :numericality => true


  def date_of_birth
    "#{self.birth_day.ordinalize} " + "#{Date::MONTHNAMES[self.birth_month]} " + "#{self.birth_year}"
  end

end
