class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile
  validates :birthday, inclusion: { in: (100.years.ago..1.day.ago), message: "must have been born within the last 100 years"}
end
