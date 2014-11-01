class Profile < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo
  belongs_to :cover_photo, :class_name => "Photo"

  validates :quotes,
            :about, length: { maximum: 1000 }
  validates :school,
            :hometown,
            :current_town,
            :phone_number, length: { maximum: 36 }

  validates :user, presence: true
end
