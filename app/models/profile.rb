class Profile < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_datetime :birthday, before: lambda { Date.current }

  belongs_to :user

end
