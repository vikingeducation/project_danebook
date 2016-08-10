class ProfileDate < ActiveRecord::Base
  belongs_to :dateable, polymorphic: true
  has_one :month
  has_one :day
  has_one :year
end
