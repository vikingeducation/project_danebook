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

  validates :gender, :presence => true

  validates :birth_day, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 },
                         :presence => true

  validates :birth_month, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 },
                         :presence => true

  validates :birth_year, numericality: { greater_than_or_equal_to: 1918, less_than_or_equal_to: 2002 },
                         :presence => true



  def date_of_birth
    "#{self.birth_day.ordinalize} " + "#{Date::MONTHNAMES[self.birth_month]} " + "#{self.birth_year}"
  end

  def date_of_birth_numbered
    "#{self.birth_day ? self.birth_day : ''}." + "#{self.birth_month ? self.birth_month : ''}." + "#{self.birth_year ? self.birth_year : ''}"
  end

  def self.searching(param)
    where("first_name LIKE ? OR last_name LIKE ?", "%#{param}%", "%#{param}%")
  end



end
