class ProfilePhoto < ActiveRecord::Base
  belongs_to :profile
  belongs_to :photo, inverse_of: :profile_photo
end
