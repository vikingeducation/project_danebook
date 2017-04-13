class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :first_name, :last_name, :sex, :birthdate, presence: true, on: :create
  validate :birthdate_not_in_future, on: :create
  validates :sex, inclusion: {in: %w(female male) }, on: :create

  private

  def birthdate_not_in_future
    if birthdate.present? && birthdate > Date.today
      errors.add(:birthdate, "It seems you're from the future. Please contact us directly.")
    end
  end

end
