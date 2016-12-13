class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  accepts_nested_attributes_for :user

  validate :over_thirteen, if: :birthday

  def over_thirteen
     errors.add(:age, "must be over 13 to sign up") unless birthday < 13.years.ago
   end
end
