class City < ApplicationRecord
  has_many :residents, foreign_key: :residency_id, class_name: "User"
  has_many :natives, foreign_key: :hometown_id, class_name: "User"

  validates :name, :country, length: { maximum: 20 }

  def location
    name + ', ' + country
  end
end
