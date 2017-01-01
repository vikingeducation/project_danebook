# Profile Model
class Profile < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_datetime :birthday,
                     before: -> { Date.current }

  belongs_to :user
end
