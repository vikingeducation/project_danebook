class Friendship < ApplicationRecord

  belongs_to :friender, foreign_key: 'friender_id', class_name: 'User'
  belongs_to :friendee, foreign_key: 'friendee_id', class_name: 'User'

  validates :friendee, :friender, presence: true

end
