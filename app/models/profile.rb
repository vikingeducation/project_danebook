class Profile < ActiveRecord::Base

  belongs_to :user

  validates :first_name, :last_name, :birthdate, :presence => true
  validates :first_name, :last_name, :length => { in: 1..24 }
  validates :gender, :inclusion => { in: [nil, "Female", "Male"], message: "must be Male, Female, or blank" }
  #validates :user_id, :uniqueness => true, :numericality => { only_integer: true }
  validate :birthdate_must_be_within_past_120_years


  def birthdate_must_be_within_past_120_years
    unless birthdate && birthdate.between?(Date.today - 120.years, Date.today)
      errors.add(:birthdate, "seems unreasonable.")
    end
  end



  def full_name
    self.first_name + " " + self.last_name
  end

end
