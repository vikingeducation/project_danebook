class Profile < ActiveRecord::Base
  # validates :user_id, presence: true
  validates :first_name, :last_name, 
            :birthday_month, :birthday_day, :birthday_year, 
            :gender, 
            :presence => true

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

  def full_name
    "#{first_name} #{last_name}"
  end


#----------------Virtual Attributes---------------
  def birthday
    if birthday_year && birthday_month && birthday_day
      DateTime.new(birthday_year,birthday_month,birthday_day).to_date
    end
  end

  def birthday=(date)
    self.birthday_year = date[1]
    self.birthday_month = date[2]
    self.birthday_day = date[3]
  end
end
