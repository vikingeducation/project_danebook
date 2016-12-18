class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  accepts_nested_attributes_for :user

  validate :over_thirteen, if: :birthday
  has_one :cover_photo, class_name: 'Photo', foreign_key: 'id'
  has_one :profile_photo, class_name: 'Photo', foreign_key: 'id'
  def over_thirteen
     errors.add(:age, "must be over 13 to sign up") unless birthday < 13.years.ago
   end
end
