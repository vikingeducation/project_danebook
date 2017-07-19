class Profile < ApplicationRecord

  belongs_to :user
  validates_presence_of :user

  validates :first_name,
            :last_name, :length => { :within => 2..20 },
            :presence => true

  validates :college,
            :hometown,
            :current_town,
            :length => { :within => 2..20 },
            :allow_blank => true

  validates :words_to_live,
            :about_me, :length => { :within => 20..250 },
            :allow_blank => true

  validates :telephone, :length => { :within => 6..20 },
                        :numericality => true,
                        :allow_blank => true

  validates :birth_day, :birth_month, :birth_year, :gender, :presence => true



  def date_of_birth
    "#{self.birth_day.ordinalize} " + "#{Date::MONTHNAMES[self.birth_month]} " + "#{self.birth_year}"
  end

  def date_of_birth_numbered
    "#{self.birth_day ? self.birth_day : ''}." + "#{self.birth_month ? self.birth_month : ''}." + "#{self.birth_year ? self.birth_year : ''}"
  end



end
