class Birthday < ActiveRecord::Base
  belongs_to :profile
  has_one :profile_date, as :dateable
end
