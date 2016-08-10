class Profile < ActiveRecord::Base
  has_one :birthday
  has_one :contact_info
  has_one :hometown
  has_one :residence
end
