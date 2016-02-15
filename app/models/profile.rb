class Profile < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :first_name
  validates_presence_of :first_name
  validate :birth_date_cannot_be_in_the_future


  def birth_date_cannot_be_in_the_future
    if birthdate.present? && birthdate >= Date.today
      errors.add(:birthdate, "Can't be in the future")
    end
  end

end
