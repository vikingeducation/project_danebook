class Profile < ApplicationRecord
  belongs_to :user
  validates :college, :hometown, :address, length: { maximum: 30 }
  validates :phone, length: { maximum: 15 }
  validates :status, length: { maximum: 120 }
  validates :about, length: { maximum: 500 }
end
