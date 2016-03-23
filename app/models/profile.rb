class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :image
  
  validates :user_id, :uniqueness => true
  validates_presence_of :first_name
  validates_presence_of :last_name
  validate :birth_date_cannot_be_in_the_future

  #validates :user, presence: true

  def birth_date_cannot_be_in_the_future
    if birthdate.present? && birthdate >= Date.today
      errors.add(:birthdate, "Can't be in the future")
    end
  end

end
