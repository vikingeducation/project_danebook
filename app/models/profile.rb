class Profile < ActiveRecord::Base

  belongs_to :user

  validates :first_name, :last_name, :birthdate, :presence => true
  validates :first_name, :last_name, :length => { in: 1..24 }
  validates :gender, :inclusion => { in: [nil, "Female", "Male"], message: "must be Male, Female, or blank" }
  validate :birthdate_must_be_within_past_120_years

  validates :college, :hometown, :currently_lives, :length => { maximum: 64 }
  validates :telephone, :length => { maximum: 24 }
  validates :words_to_live_by, :length => { maximum: 140 }
  validates :description, :length => { maximum: 500 }


  def birthdate_must_be_within_past_120_years
    unless birthdate && birthdate.between?(Date.today - 120.years, Date.today)
      errors.add(:birthdate, "seems unreasonable.")
    end
  end


  def full_name
    self.first_name + " " + self.last_name
  end


  def self.search(query = "")
    if query.empty?
      none
    else
      where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{query.downcase}%", "%#{query.downcase}%")
    end
  end

end
