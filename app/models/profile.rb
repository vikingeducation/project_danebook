class Profile < ActiveRecord::Base
  belongs_to :user

  validates :quotes,
            :about, length: { maximum: 1000 }
  validates :school,
            :hometown,
            :current_town,
            :phone_number, length: { maximum: 36 }

  validates :user, presence: true
end
