class City < ApplicationRecord
  has_many :residents, foreign_key: :hometown_id, class_name: "User"
  has_many :natives, foreign_key: :curr_addr_id, class_name: "User"
end
