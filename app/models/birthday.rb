class Birthday < ActiveRecord::Base
  belongs_to :profile
  has_one :profile_date, as: :dateable

  accepts_nested_attributes_for :profile_date
end
