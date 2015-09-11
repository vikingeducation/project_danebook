class Profile < ActiveRecord::Base
  # validates :user_id, presence: true
  validates :first_name, :last_name, 
            :birthday_month, :birthday_day, :birthday_year, :birthday,
            :gender, 
            :presence => true

  validate  :validate_birthday_within

  validates :hometown, 
            :current_lives, 
            :college,
            length: { maximum: 50 }

  validates :telephone, 
            length: { maximum: 30 }

  validates :words_to_live_by, 
            :about_me, 
            length: { maximum: 500 }

  belongs_to :user

#----------------  Methods  ---------------

  def full_name
    "#{first_name} #{last_name}"
  end

#----------------  Validator  --------------- 

  def validate_birthday_within
    if !self.birthday
      self.errors.add(:birthday, "Must have a birthday!")
    elsif self.birthday < (Time.now.to_date - 100*365)
      self.errors.add(:birthday, "Sorry, our site is too dangerous for a 100-year-old man!")
    elsif self.birthday > (Time.now.to_date - 12*365)
      self.errors.add(:birthday, "Sorry, you must be at least 12 to use our site!")
    end
  end


#----------------Virtual Attributes---------------
  def birthday
    if birthday_year && birthday_month && birthday_day
      DateTime.new(birthday_year,birthday_month,birthday_day).to_date
    end
  end

  def birthday=(date)
    unless date.empty?
      fields = date.split('-')
      self.birthday_year = fields[0].to_i
      self.birthday_month = fields[1].to_i
      self.birthday_day = fields[2].to_i
    end
  end
end
